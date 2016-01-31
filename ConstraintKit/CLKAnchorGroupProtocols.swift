//
//  CLKAnchorGroupProtocols.swift
//  ConstraintKit
//
//  Created by Jed Lewison / Magic App Factory on 1/30/16.
//  MIT License All rights reserved.
//

import UIKit

/// `CLKEquivalentConstraintPolicy` defines how ConstraintKit handles existing constraints when activating or updating constraints.
@objc public enum CLKEquivalentConstraintPolicy: Int {
    /// Completely ignore existing constraints. Useful when installing constraints with multiple priorities.
    case IgnoreExisting
    /// Default. Update existing constraints when possible and remove duplicates.
    case UpdateExisting
}

internal protocol CLKAnchorGroupProtocol {

    func activate() -> [NSLayoutConstraint]
    func activate(policy: CLKEquivalentConstraintPolicy) -> [NSLayoutConstraint]
    func deactivate()

    func constraintsEqualTo(view: UIView) -> Self
    func constraintsGreaterThanOrEqualTo(view: UIView) -> Self
    func constraintsLessThanOrEqualTo(view: UIView) -> Self

    func constraintsEqualTo(viewController: UIViewController) -> Self
    func constraintsGreaterThanOrEqualTo(viewController: UIViewController) -> Self
    func constraintsLessThanOrEqualTo(viewController: UIViewController) -> Self

    func constraintsEqualTo(layoutGuide: UILayoutGuide) -> Self?
    func constraintsGreaterThanOrEqualTo(layoutGuide: UILayoutGuide) -> Self?
    func constraintsLessThanOrEqualTo(layoutGuide: UILayoutGuide) -> Self?

}

internal protocol CLKAnchorGroupSubclassProtocol: CLKAnchorGroupProtocol {

    typealias Constant

    func with(constant: Constant, priority: UILayoutPriority) -> Self

    var anchors: [LayoutAnchor] { get }
}

internal protocol CLKAnchorDimensionGroupProtocol: CLKAnchorGroupSubclassProtocol {

    func constraintsEqualTo(constant: Constant) -> Self
    func constraintsGreaterThanOrEqualTo(constant: Constant) -> Self
    func constraintsLessThanOrEqualTo(constant: Constant) -> Self

    func with(multiplier: CGFloat, size: Constant, priority: UILayoutPriority) -> Self

}

