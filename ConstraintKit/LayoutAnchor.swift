//
//  LayoutAnchor.swift
//  ConstraintKit
//
//  Created by Jed Lewison / Magic App Factory on 1/30/16.
//  MIT License All rights reserved.
//

import UIKit

enum LayoutAnchor {
    case Leading
    case Top
    case Trailing
    case Bottom
    case Width
    case Height
    case CenterX
    case CenterY

    func anchorForAnchorGroup(anchorGroup: CLKAnchorGroup?) -> NSLayoutAnchor? {
        guard let anchorGroup = anchorGroup else { return nil }
        return anchorForAnchorGroup(anchorGroup)
    }

    func orderedAnchorGroups(fromAnchorGroup: CLKAnchorGroup, toAnchorGroup: CLKAnchorGroup?) -> (firstGroup: CLKAnchorGroup?, secondGroup: CLKAnchorGroup?) {
        switch self {
        case .Trailing, .Bottom:
            return (firstGroup: toAnchorGroup, secondGroup: fromAnchorGroup)
        case .Leading, .Top, .Width, .Height, .CenterX, .CenterY:
            return (firstGroup: fromAnchorGroup, secondGroup: toAnchorGroup)
        }
    }

    func anchorForAnchorGroup(anchorGroup: CLKAnchorGroup) -> NSLayoutAnchor? {
        switch self {
        case .Leading:
            return anchorGroup.anchorView?.leadingAnchor
        case .Top:
            return anchorGroup.viewController?.topLayoutGuide.bottomAnchor ?? anchorGroup.anchorView?.topAnchor
        case .Trailing:
            return anchorGroup.anchorView?.trailingAnchor
        case .Bottom:
            return anchorGroup.viewController?.bottomLayoutGuide.topAnchor ?? anchorGroup.anchorView?.bottomAnchor
        case .Width:
            return anchorGroup.anchorView?.widthAnchor
        case .Height:
            return anchorGroup.anchorView?.heightAnchor
        case .CenterX:
            return anchorGroup.anchorView?.centerXAnchor
        case .CenterY:
            return anchorGroup.anchorView?.centerYAnchor
        }
    }

    func constantForAnchorGroup(anchorGroup: CLKAnchorGroup) -> CGFloat {
        switch self {
        case .Leading:
            return anchorGroup.config.insets.left
        case .Top:
            return anchorGroup.config.insets.top
        case .Trailing:
            return anchorGroup.config.insets.right
        case .Bottom:
            return anchorGroup.config.insets.bottom
        case .Width:
            return anchorGroup.config.size.width
        case .Height:
            return anchorGroup.config.size.height
        case .CenterX:
            return anchorGroup.config.centerOffset.x
        case .CenterY:
            return anchorGroup.config.centerOffset.y
        }
    }
}