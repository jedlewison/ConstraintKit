//
//  CLKCenterAnchorGroup.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/30/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import UIKit

public final class CLKCenterAnchorGroup: CLKAnchorGroup, CLKAnchorGroupSubclassProtocol {

    public typealias Constant = CGPoint

    func with(centerOffset: CGPoint? = nil, priority: UILayoutPriority? = nil) -> Self {
        with(centerOffset ?? config.centerOffset, priority: priority ?? config.priority)
        return self
    }

    @objc(withConstant:priority:)
    func with(centerOffset: CGPoint, priority: UILayoutPriority) -> Self {
        config.centerOffset = centerOffset
        config.priority = priority
        return self
    }

}
