//
//  CLKSizeAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/30/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import UIKit

public final class CLKSizeAnchorGroup: CLKAnchorGroup, CLKAnchorDimensionGroupProtocol {

    public typealias Constant = CGSize

    func with(size: CGSize? = nil, multiplier: CGFloat? = nil, priority: UILayoutPriority? = nil) -> Self {
        with(multiplier ?? config.multiplier, size: size ?? config.size, priority: priority ?? config.priority)
        return self
    }

    @objc(withMultiplier:size:priority:)
    func with(multiplier: CGFloat, size: CGSize, priority: UILayoutPriority) -> Self {
        config.multiplier = multiplier
        config.size = size
        config.priority = priority
        return self
    }

    @objc(withConstant:priority:)
    func with(size: CGSize, priority: UILayoutPriority) -> Self {
        config.size = size
        config.priority = priority
        return self
    }

    @objc(constraintsEqualToConstant:)
    public func constraintsEqualTo(constant: Constant) -> CLKSizeAnchorGroup {
        config = Configuration(relation: .Equal, size: constant)
        return self
    }

    @objc(constraintsGreaterThanOrEqualToConstant:)
    public func constraintsGreaterThanOrEqualTo(constant: Constant) -> CLKSizeAnchorGroup {
        config = Configuration(relation: .GreaterThanOrEqual, size: constant)
        return self
    }

    @objc(constraintsLessThanOrEqualToConstant:)
    public func constraintsLessThanOrEqualTo(constant: Constant) -> CLKSizeAnchorGroup {
        config = Configuration(relation: .LessThanOrEqual, size: constant)
        return self
    }

}
