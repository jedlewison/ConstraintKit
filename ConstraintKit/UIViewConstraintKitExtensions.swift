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

    public var clk_edgesAnchor: CLKEdgesAnchorGroup {
        return CLKEdgesAnchorGroup(self)
    }

    public var clk_sizeAnchor: CLKSizeAnchorGroup {
        return CLKSizeAnchorGroup(self)
    }

    public var clk_centerAnchor: CLKCenterAnchorGroup {
        return CLKCenterAnchorGroup(self)
    }

}

extension UILayoutGuide: CLKAnchorable {

    public var clk_edgesAnchor: CLKEdgesAnchorGroup {
        return CLKEdgesAnchorGroup(self)
    }

    public var clk_sizeAnchor: CLKSizeAnchorGroup {
        return CLKSizeAnchorGroup(self)
    }

    public var clk_centerAnchor: CLKCenterAnchorGroup {
        return CLKCenterAnchorGroup(self)
    }

}

extension UIViewController: CLKAnchorable {

    public var clk_edgesAnchor: CLKEdgesAnchorGroup {
        return CLKEdgesAnchorGroup(self)
    }

    public var clk_sizeAnchor: CLKSizeAnchorGroup {
        return CLKSizeAnchorGroup(self)
    }

    public var clk_centerAnchor: CLKCenterAnchorGroup {
        return CLKCenterAnchorGroup(self)
    }
}

