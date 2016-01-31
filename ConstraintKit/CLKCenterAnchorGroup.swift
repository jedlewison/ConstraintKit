//
//  CLKCenterAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison / Magic App Factory on 1/30/16.
//  MIT License All rights reserved.
//

import UIKit

/// An anchor group for constraining to centers.
public final class CLKCenterAnchorGroup: CLKAnchorGroup, CLKAnchorGroupSubclassProtocol {

    public typealias Constant = CGPoint

    /// Specify centerOffset and/or priority values for the anchor group's constraints. Must be called prior to activation.
    public func with(centerOffset: CGPoint? = nil, priority: UILayoutPriority? = nil) -> Self {
        with(centerOffset ?? config.centerOffset, priority: priority ?? config.priority)
        return self
    }

    /// Specify centerOffset and priority values for the anchor group's constraints. Must be called prior to activation.
    @objc(withConstant:priority:)
    public func with(centerOffset: CGPoint, priority: UILayoutPriority) -> Self {
        config.centerOffset = centerOffset
        config.priority = priority
        return self
    }

}
