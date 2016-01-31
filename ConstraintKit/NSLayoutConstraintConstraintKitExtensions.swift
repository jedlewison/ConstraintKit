
//
//  NSLayoutConstraintExtensions.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/24/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import Foundation
import UIKit

enum LayoutConstraintError: ErrorType {
    case InvalidFirstItem(Any)
    case InvalidSecondItem(Any)
    case InvalidViewHierarchy
    case MissingAnchorGroup
}

extension NSLayoutConstraint {

    public func clk_withPriority(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    public func clk_activate() -> NSLayoutConstraint {
        return clk_activate(.UpdateExisting)
    }

    public func clk_deactivate() -> [NSLayoutConstraint] {
        let constraintsToDeactivate = [self] + clk_findIdentical()
        NSLayoutConstraint.deactivateConstraints(constraintsToDeactivate)
        return constraintsToDeactivate
    }

    @objc(clk_activateWithPolicy:)
    public func clk_activate(policy: CLKEquivalentConstraintPolicy) -> NSLayoutConstraint {
        do {
            let preparedConstraints = try clk_prepareWithPolicy(policy)
            NSLayoutConstraint.deactivateConstraints(preparedConstraints.constraintsToDeactivate)
            NSLayoutConstraint.activateConstraints([preparedConstraints.constraintToActivate])
            return preparedConstraints.constraintToActivate
        } catch {
            debugPrint(error)
            return self
        }
    }

}

extension NSLayoutConstraint {

    func clk_constraintsForPolicy(policy: CLKEquivalentConstraintPolicy) throws -> (constraintToActivate: NSLayoutConstraint, constraintsToDeactivate: [NSLayoutConstraint]) {

        let constraintToConfigure: NSLayoutConstraint
        let constraintsToDeactivate: [NSLayoutConstraint]

        switch policy {
        case .IgnoreExisting:
            constraintToConfigure = self
            constraintsToDeactivate = []
        case .UpdateExisting:
            constraintToConfigure = clk_findEquivalent().first ?? self
            constraintsToDeactivate = clk_findEquivalent().filter { $0 !== constraintToConfigure }
        }

        return (constraintToActivate: constraintToConfigure, constraintsToDeactivate: constraintsToDeactivate)
    }

    func clk_prepareWithPolicy(policy: CLKEquivalentConstraintPolicy) throws -> (constraintToActivate: NSLayoutConstraint, constraintsToDeactivate: [NSLayoutConstraint]) {

        let constraints = try clk_constraintsForPolicy(policy)
        constraints.constraintToActivate.constant = constant
        constraints.constraintToActivate.priority = priority

        if !constraints.constraintToActivate.active {
            try constraints.constraintToActivate.prepareTranslatesAutoresizingMasks()
        }

        return constraints
    }

    func clk_findEquivalent() -> [NSLayoutConstraint] {
        do {
            let targetViewForConstraint = try findTargetViewForConstraint()
            return targetViewForConstraint.constraints.filter(isEquivalentToConstraint)
        } catch {
            debugPrint(error)
            return []
        }
    }

    /// Returns all constraints with identical properties except for active
    func clk_findIdentical() -> [NSLayoutConstraint] {
        do {
            let targetViewForConstraint = try findTargetViewForConstraint()
            return targetViewForConstraint.constraints.filter(isEqualTo)
        } catch {
            debugPrint(error)
            return []
        }
    }

}

extension CollectionType {

    /// Returns the first element where `predicate` returns `true` for the
    /// corresponding value, or `nil` if such value is not found.
    ///
    /// - Complexity: O(`self.count`).
    @warn_unused_result
    func findFirst(@noescape predicate: (Self.Generator.Element) throws -> Bool) rethrows -> Self.Generator.Element? {
        for element in self where try predicate(element) {
            return element
        }
        return nil
    }

}

private extension NSLayoutConstraint {

    func clk_findExistingConstraint() throws -> NSLayoutConstraint? {
        let targetViewForConstraint = try findTargetViewForConstraint()
        return targetViewForConstraint.constraints.findFirst(isEquivalentToConstraint)
    }
    
}


private extension NSLayoutConstraint {

    typealias ViewClass = UIView

    func isEquivalentToConstraint(other: NSLayoutConstraint) -> Bool {
        return firstItem === other.firstItem &&
            firstAttribute == other.firstAttribute &&
            relation == other.relation &&
            secondItem === other.secondItem &&
            secondAttribute == other.secondAttribute &&
            priority == other.priority
    }

    // Except active :)
    func isEqualTo(other: NSLayoutConstraint) -> Bool {
        return firstItem === other.firstItem &&
            firstAttribute == other.firstAttribute &&
            relation == other.relation &&
            secondItem === other.secondItem &&
            secondAttribute == other.secondAttribute &&
            constant == other.constant &&
            priority == other.priority
    }

    func firstItemView() throws -> ViewClass {
        if let firstItem = firstItem as? ViewClass {
            return firstItem
        } else if let firstItem = firstItem as? UILayoutGuide,
            owningView = firstItem.owningView {
                return owningView
        }

        throw LayoutConstraintError.InvalidFirstItem(self.firstItem)

    }

    func secondItemView() throws -> ViewClass? {

        if let secondItem = secondItem as? ViewClass? {
            return secondItem
        } else if let secondItem = secondItem as? UILayoutGuide,
            owningView = secondItem.owningView {
                return owningView
        }

        throw LayoutConstraintError.InvalidSecondItem(self.secondItem)
    }

    func findTargetViewForConstraint() throws -> ViewClass {

        let firstItem = try firstItemView()
        guard let secondItemView = try secondItemView() else { return firstItem }
        guard let targetViewForConstraint = firstItem.firstCommonAncestorWithView(secondItemView) else {
            debugPrint(firstItem, secondItemView)
            throw LayoutConstraintError.InvalidViewHierarchy
        }
        return targetViewForConstraint

    }

    func prepareTranslatesAutoresizingMasks() throws {

        let targetViewForConstraint = try findTargetViewForConstraint()

        let firstView = try firstItemView()
        let secondView = try secondItemView()
        if targetViewForConstraint !== firstView {
            firstView.translatesAutoresizingMaskIntoConstraints = false
        }

        if targetViewForConstraint !== secondView {
            secondView?.translatesAutoresizingMaskIntoConstraints = false
        }

    }
}

private extension UIView {
    func firstCommonAncestorWithView(otherView: UIView) -> UIView? {
        if otherView.isDescendantOfView(self) {
            return self
        } else if isDescendantOfView(otherView) {
            return otherView
        } else {
            return superview?.firstCommonAncestorWithView(otherView)
        }
    }
}
