//
//  CLKSizeAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/30/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import UIKit

/// An anchor group for constraining to size.
public final class CLKSizeAnchorGroup: CLKAnchorGroup, CLKAnchorDimensionGroupProtocol {

    public typealias Constant = CGSize

    /// Specify size, multiplier, and priority values for the anchor group's constraints. Must be called prior to activation.
    public func with(size: CGSize? = nil, multiplier: CGFloat? = nil, priority: UILayoutPriority? = nil) -> Self {
        with(multiplier ?? config.multiplier, size: size ?? config.size, priority: priority ?? config.priority)
        return self
    }

    /// Specify size, multiplier, and priority values for the anchor group's constraints. Must be called prior to activation.
    @objc(withMultiplier:size:priority:)
    public func with(multiplier: CGFloat, size: CGSize, priority: UILayoutPriority) -> Self {
        config.multiplier = multiplier
        config.size = size
        config.priority = priority
        return self
    }

    /// Specify size and priority values for the anchor group's constraints. Must be called prior to activation.
    @objc(withConstant:priority:)
    public func with(size: CGSize, priority: UILayoutPriority) -> Self {
        config.size = size
        config.priority = priority
        return self
    }

    /// Generates constraints that defines the anchor group's size equal to the specified constant.
    @objc(constraintsEqualToConstant:)
    public func constraintsEqualTo(constant: Constant) -> CLKSizeAnchorGroup {
        config = Configuration(relation: .Equal, size: constant)
        return self
    }

    /// Generates constraints that defines the anchor group's size to greater than the specified constant.
    @objc(constraintsGreaterThanOrEqualToConstant:)
    public func constraintsGreaterThanOrEqualTo(constant: Constant) -> CLKSizeAnchorGroup {
        config = Configuration(relation: .GreaterThanOrEqual, size: constant)
        return self
    }

    /// Generates constraints that defines the anchor group's size to less than the specified constant.
    @objc(constraintsLessThanOrEqualToConstant:)
    public func constraintsLessThanOrEqualTo(constant: Constant) -> CLKSizeAnchorGroup {
        config = Configuration(relation: .LessThanOrEqual, size: constant)
        return self
    }

}
