//
//  CLKAnchorGroupProtocols.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/30/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import UIKit

@objc public enum CLKEquivalentConstraintPolicy: Int {
    case IgnoreExisting
    case UpdateExisting
}

protocol CLKAnchorGroupProtocol: NSObjectProtocol {

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

protocol CLKAnchorGroupSubclassProtocol: CLKAnchorGroupProtocol {

    typealias Constant

    func with(constant: Constant, priority: UILayoutPriority) -> Self

    var anchors: [LayoutAnchor] { get }
}

protocol CLKAnchorDimensionGroupProtocol: CLKAnchorGroupSubclassProtocol {

    func constraintsEqualTo(constant: Constant) -> Self
    func constraintsGreaterThanOrEqualTo(constant: Constant) -> Self
    func constraintsLessThanOrEqualTo(constant: Constant) -> Self

    func with(multiplier: CGFloat, size: Constant, priority: UILayoutPriority) -> Self

}

