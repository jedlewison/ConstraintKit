//
//  CLKEdgesAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison / Magic App Factory on 1/30/16.
//  MIT License All rights reserved.
//

import UIKit

/// An anchor group for constraining to edges. Uses top, bottom, leading, and trailing anchors except with viewController's, where is uses top and bottom layout guides.
public final class CLKEdgesAnchorGroup: CLKAnchorGroup, CLKAnchorGroupSubclassProtocol {

    public typealias Constant = UIEdgeInsets

    /// Specify insets and/or priority values for the anchor group's constraints. Must be called prior to activation.
    public func with(insets: UIEdgeInsets? = nil, priority: UILayoutPriority? = nil) -> Self {
        with(insets ?? config.insets, priority: priority ?? config.priority)
        return self
    }

    /// Specify insets and priority values for the anchor group's constraints. Must be called prior to activation.
    @objc(withConstant:priority:)
    public func with(insets: UIEdgeInsets, priority: UILayoutPriority) -> Self {
        config.insets = insets
        config.priority = priority
        return self
    }
    
}