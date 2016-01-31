//
//  UIViewConstraintKitExtensions.swift
//  ConstraintKit
//
//  Created by Jed Lewison / Magic App Factory on 1/24/16.
//  MIT License.
//

import UIKit


internal protocol CLKAnchorable: NSObjectProtocol {

    var clk_edgesAnchor: CLKEdgesAnchorGroup { get }
    var clk_sizeAnchor: CLKSizeAnchorGroup { get }
    var clk_centerAnchor: CLKCenterAnchorGroup { get }

}

/// Anchor groups for use with views.
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

/// Anchor groups for use with layout guides. The layout guide must be installed for the anchor group to generate constraints.
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

/// Anchor groups for use with view controller. The view controller's view must be loaded for the anchor group to generate constraints.
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

