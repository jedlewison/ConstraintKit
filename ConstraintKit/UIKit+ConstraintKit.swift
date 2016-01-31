//
//  UIViewConstraintKitExtensions.swift
//  ConstraintKit
//
//  Created by Jed Lewison on 1/24/16.
//  Copyright © 2016 Magic App Factory. All rights reserved.
//

import UIKit


public protocol CLKAnchorable: NSObjectProtocol {

    var clk_edgesAnchor: CLKEdgesAnchorGroup { get }
    var clk_sizeAnchor: CLKSizeAnchorGroup { get }
    var clk_centerAnchor: CLKCenterAnchorGroup { get }

}

extension UIView: CLKAnchorable {

    /// An anchor group representing the view's edges.
    public var clk_edgesAnchor: CLKEdgesAnchorGroup {
        return CLKEdgesAnchorGroup(self)
    }

    /// An anchor group representing the view's size.
    public var clk_sizeAnchor: CLKSizeAnchorGroup {
        return CLKSizeAnchorGroup(self)
    }

    /// An anchor group representing the view's size.
    public var clk_centerAnchor: CLKCenterAnchorGroup {
        return CLKCenterAnchorGroup(self)
    }

}

extension UILayoutGuide: CLKAnchorable {

    /// An anchor group representing the guide's edges.
    public var clk_edgesAnchor: CLKEdgesAnchorGroup {
        return CLKEdgesAnchorGroup(self)
    }

    /// An anchor group representing the guide's size.
    public var clk_sizeAnchor: CLKSizeAnchorGroup {
        return CLKSizeAnchorGroup(self)
    }

    /// An anchor group representing the guide's center.
    public var clk_centerAnchor: CLKCenterAnchorGroup {
        return CLKCenterAnchorGroup(self)
    }

}

extension UIViewController: CLKAnchorable {

    /// An anchor group representing the viewController's view's horizontal edges and top and bottom layout guides.
    public var clk_edgesAnchor: CLKEdgesAnchorGroup {
        return CLKEdgesAnchorGroup(self)
    }

    /// An anchor group representing the viewController's view's size.
    public var clk_sizeAnchor: CLKSizeAnchorGroup {
        return CLKSizeAnchorGroup(self)
    }

    /// An anchor group representing the viewController's view's center.
    public var clk_centerAnchor: CLKCenterAnchorGroup {
        return CLKCenterAnchorGroup(self)
    }
}

