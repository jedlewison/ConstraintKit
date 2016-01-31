//
//  CLKAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison / Magic App Factory on 1/30/16.
//  MIT License All rights reserved.
//

import UIKit

/// A CLKAnchorGroup represents a group of layout anchors. Like NSLayoutAnchor it is a factory class with the primary purpose of generating constraints. Use the `clk_edgesAnchor`, `clk_centerAnchor`, and `clk_sizeAnchor` properties of `UIView`, and `UIViewController`, and `UILayoutGuide` instances to use anchor groups to create, activate, and deactive constraints.
public class CLKAnchorGroup: NSObject {

    let viewController: UIViewController?
    let view: UIView?
    let layoutGuide: UILayoutGuide?
    var anchorView: UIView? {
        return view ?? viewController?.viewIfLoaded ?? layoutGuide?.owningView
    }
    var config = Configuration(relation: .Equal)

    init(view: UIView? = nil, viewController: UIViewController? = nil, layoutGuide: UILayoutGuide? = nil) {
        self.view = view
        self.viewController = viewController
        self.layoutGuide = layoutGuide
        super.init()
    }

    @objc(initWithView:)
    convenience init(_ view: UIView) {
        self.init(view: view)
    }

    @objc(initWithLayoutGuide:)
    convenience init(_ layoutGuide: UILayoutGuide) {
        self.init(layoutGuide: layoutGuide)
    }

    @objc(initWithViewController:)
    convenience init(_ viewController: UIViewController) {
        self.init(viewController: viewController)
    }

}

extension CLKAnchorGroup: CLKAnchorGroupProtocol {

    private func anchorGroupFor(anchorable: CLKAnchorable) -> CLKAnchorGroup {
        switch self {
        case _ as CLKSizeAnchorGroup:
            return anchorable.clk_sizeAnchor
        case _ as CLKCenterAnchorGroup:
            return anchorable.clk_centerAnchor
        case _ as CLKEdgesAnchorGroup:
            return anchorable.clk_edgesAnchor
        case _:
            return CLKAnchorGroup(view: nil, viewController: nil, layoutGuide: nil)
        }
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as equal to the view's anchor group of the same kind.
    @objc(constraintsEqualToView:)
    public func constraintsEqualTo(view: UIView) -> Self {
        config = Configuration(relation: .Equal, toAnchorGroup: anchorGroupFor(view))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as greater than or equal to the view's anchor group of the same kind.
    @objc(constraintsGreaterThanOrEqualToView:)
    public func constraintsGreaterThanOrEqualTo(view: UIView) -> Self {
        config = Configuration(relation: .GreaterThanOrEqual, toAnchorGroup: anchorGroupFor(view))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as less than or equal to the view's anchor group of the same kind.
    @objc(constraintsLessThanOrEqualToView:)
    public func constraintsLessThanOrEqualTo(view: UIView) -> Self {
        config = Configuration(relation: .LessThanOrEqual, toAnchorGroup: anchorGroupFor(view))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as equal to the view controller's anchor group of the same kind.
    @objc(constraintsEqualToViewController:)
    public func constraintsEqualTo(viewController: UIViewController) -> Self {
        config = Configuration(relation: .Equal, toAnchorGroup: anchorGroupFor(viewController))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as greater than or equal to the view controller's anchor group of the same kind.
    @objc(constraintsEqualToOrGreaterThanViewController:)
    public func constraintsGreaterThanOrEqualTo(viewController: UIViewController) -> Self {
        config = Configuration(relation: .GreaterThanOrEqual, toAnchorGroup: anchorGroupFor(viewController))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as less than or equal to the layout guide's anchor group of the same kind.
    @objc(constraintsLessThanOrEqualToViewController:)
    public func constraintsLessThanOrEqualTo(viewController: UIViewController) -> Self {
        config = Configuration(relation: .LessThanOrEqual, toAnchorGroup: anchorGroupFor(viewController))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as equal to the layout guide's anchor group of the same kind.
    @objc(constraintsEqualToLayoutGuide:)
    public func constraintsEqualTo(layoutGuide: UILayoutGuide) -> Self? {
        config = Configuration(relation: .Equal, toAnchorGroup: anchorGroupFor(layoutGuide))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as greater than or equal to the layout guide's anchor group of the same kind.
    @objc(constraintsEqualToOrGreaterThanLayoutGuide:)
    public func constraintsGreaterThanOrEqualTo(layoutGuide: UILayoutGuide) -> Self? {
        config = Configuration(relation: .GreaterThanOrEqual, toAnchorGroup: anchorGroupFor(layoutGuide))
        return self
    }

    /// Specifies that constraints should be generated defining the anchor group's attributes as less than or equal to the layout guide's anchor group of the same kind.
    @objc(constraintsLessThanOrEqualToLayoutGuide:)
    public func constraintsLessThanOrEqualTo(layoutGuide: UILayoutGuide) -> Self? {
        config = Configuration(relation: .LessThanOrEqual, toAnchorGroup: anchorGroupFor(layoutGuide))
        return self
    }

}

extension CLKAnchorGroup {

    struct Configuration {
        let toAnchorGroup: CLKAnchorGroup?
        let relation: NSLayoutRelation
        var insets: UIEdgeInsets
        var centerOffset: CGPoint
        var size: CGSize
        var multiplier: CGFloat
        var priority: UILayoutPriority = UILayoutPriorityRequired

        init(relation: NSLayoutRelation, toAnchorGroup: CLKAnchorGroup? = nil, insets: UIEdgeInsets = UIEdgeInsetsZero, centerOffset: CGPoint = .zero, size: CGSize = .zero, multiplier: CGFloat = 1) {
            self.toAnchorGroup = toAnchorGroup
            self.relation = relation
            self.insets = insets
            self.centerOffset = centerOffset
            self.size = size
            self.multiplier = multiplier
        }
    }

    /// Activates constraints defined by the anchor group.
    /// Disables `translatesAutoresizingMaskIntoConstraints` on views as needed.
    /// Uses the `.UpdateExisting` constraint activation policy, so when possible, existing constraints will be used with updated constants and/or priorities.
    ///
    /// - returns: The newly activated or updated constraints.
    public func activate() -> [NSLayoutConstraint] {
        return activate(.UpdateExisting)
    }

    /// Deactivates any existing constraints that would have been activated by calling `activate()`.
    /// Useful when reconfiguring constraints.
    public func deactivate() {

        do {
            let constraintsToDeactivate = try getConstraints()
                .map { try $0.clk_constraintsForPolicy(.UpdateExisting) }
                .map { [ $0.constraintToActivate ] + $0.constraintsToDeactivate }
                .flatMap { $0.filter { $0.active } }
            NSLayoutConstraint.deactivateConstraints(constraintsToDeactivate)
        } catch {
            debugPrint(error)
        }

    }

    /// Activates constraints defined by the anchor group.
    /// Disables `translatesAutoresizingMaskIntoConstraints` on views as needed.
    /// With the `.UpdateExisting` constraint activation policy, existing constraints will be used with updated constants and/or priorities whenever possible.
    /// With the `.IgnoreExisting` constraint activation policy, existing constraints will not be affected. Use this for installing multiple similar constraints with different layout priorities.
    /// - returns: The newly activated or updated constraints.
    @objc(activateWithPolicy:)
    public func activate(policy: CLKEquivalentConstraintPolicy) -> [NSLayoutConstraint] {
        do {
            let preparedConstraints = try getConstraints().map { try $0.clk_prepareWithPolicy(policy) }
            let constraintsToActivate = preparedConstraints.flatMap { $0.constraintToActivate }
            let constraintsToDeactivate = preparedConstraints.flatMap { $0.constraintsToDeactivate }
            NSLayoutConstraint.deactivateConstraints(constraintsToDeactivate)
            NSLayoutConstraint.activateConstraints(constraintsToActivate)
            return constraintsToActivate
        } catch {
            debugPrint(error)
            return []
        }
    }

    var anchors: [LayoutAnchor] {
        switch self {
        case _ as CLKSizeAnchorGroup:
            return [.Width, .Height]
        case _ as CLKCenterAnchorGroup:
            return [.CenterX, .CenterY]
        case _ as CLKEdgesAnchorGroup:
            return [.Top, .Leading, .Bottom, .Trailing]
        case _:
            return []
        }
    }

    private func getConstraints() -> [NSLayoutConstraint] {

        do {
            return try anchors.map(constraintForAnchor)
        } catch {
            debugPrint(error)
            return []
        }
    }

    private func makeConstraintFromLayoutAnchor(anchor fromAnchor: NSLayoutAnchor, toAnchor: NSLayoutAnchor?, relation: NSLayoutRelation, constant: CGFloat, multiplier: CGFloat) throws -> NSLayoutConstraint {

        if let fromAnchor = fromAnchor as? NSLayoutDimension,
            toAnchor = toAnchor as? NSLayoutDimension {
                switch relation {
                case .Equal:
                    return fromAnchor.constraintEqualToAnchor(toAnchor, multiplier: multiplier, constant: constant)
                case .GreaterThanOrEqual:
                    return fromAnchor.constraintGreaterThanOrEqualToAnchor(toAnchor, multiplier: multiplier, constant: constant)
                case .LessThanOrEqual:
                    return fromAnchor.constraintLessThanOrEqualToAnchor(toAnchor, multiplier: multiplier, constant: constant)
                }
        } else if let toAnchor = toAnchor {
            switch relation {
            case .Equal:
                return fromAnchor.constraintEqualToAnchor(toAnchor, constant: constant)
            case .GreaterThanOrEqual:
                return fromAnchor.constraintGreaterThanOrEqualToAnchor(toAnchor, constant: constant)
            case .LessThanOrEqual:
                return fromAnchor.constraintLessThanOrEqualToAnchor(toAnchor, constant: constant)
            }
        } else if let fromAnchor = fromAnchor as? NSLayoutDimension {
            switch relation {
            case .Equal:
                return fromAnchor.constraintEqualToConstant(constant)
            case .GreaterThanOrEqual:
                return fromAnchor.constraintGreaterThanOrEqualToConstant(constant)
            case .LessThanOrEqual:
                return fromAnchor.constraintLessThanOrEqualToConstant(constant)
            }
        } else {
            throw LayoutConstraintError.MissingAnchorGroup
        }
    }

    private func constraintForAnchor(anchor: LayoutAnchor) throws -> NSLayoutConstraint {

        let orderedAnchorGroupsForAnchor = anchor.orderedAnchorGroups(self, toAnchorGroup: config.toAnchorGroup)
        guard let firstGroup = orderedAnchorGroupsForAnchor.firstGroup else {
            throw LayoutConstraintError.MissingAnchorGroup
        }

        guard let fromAnchor = anchor.anchorForAnchorGroup(firstGroup) else {
            throw LayoutConstraintError.MissingAnchorGroup
        }
        let toAnchor: NSLayoutAnchor? = anchor.anchorForAnchorGroup(orderedAnchorGroupsForAnchor.secondGroup)
        let constant: CGFloat = anchor.constantForAnchorGroup(self)

        return try makeConstraintFromLayoutAnchor(anchor: fromAnchor, toAnchor: toAnchor, relation: config.relation, constant: constant, multiplier: config.multiplier)
    }
    
}
