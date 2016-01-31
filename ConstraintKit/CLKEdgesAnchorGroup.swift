//
//  CLKEdgesAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/30/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import UIKit

public final class CLKEdgesAnchorGroup: CLKAnchorGroup, CLKAnchorGroupSubclassProtocol {

    public typealias Constant = UIEdgeInsets

    func with(insets: UIEdgeInsets? = nil, priority: UILayoutPriority? = nil) -> Self {
        with(insets ?? config.insets, priority: priority ?? config.priority)
        return self
    }

    @objc(withConstant:priority:)
    func with(insets: UIEdgeInsets, priority: UILayoutPriority) -> Self {
        config.insets = insets
        config.priority = priority
        return self
    }
    
}