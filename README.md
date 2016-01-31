# ConstraintKit

ConstraintKit makes it easy to activate, deactivate, and update layout constraints on iOS in Swift and Objective-C. It intelligently disables ```translatesAutoresizingMaskIntoConstraints``` on views participating in auto-layout, lets you update installed constraints without storing references to them, and lets you activate individual constraints in a single line of code, but it's most powerful feature is that it lets define the layout for an entire view in just one line.

Let's say you've added a view to your view controller's main view, and you want it to fill the entire view between the top and bottom layout guides. Here's how you do it with ConstraintKit using Swift...

```swift
newView.clk_edgesAnchor.constraintsEqualTo(self).activate()
```

...and in Objective-C:

```objective-c
[[[newView clk_edgesAnchor] constraintsEqualToViewController:self] activate];
```

Lets say you wanted to add margins to your newView. Simply create UIEdgeInsets defining the margin and use those when activating the constraints:

```swift
newView.clk_edgesAnchor.constraintsEqualTo(self).with(insets).activate()
```

...and in Objective-C:

```objective-c
[[[newView clk_edgesAnchor] constraintsEqualToViewController:self] withConstant:insets priority:UILayoutPriorityRequired];
```

One nice thing with ConstraintKit is that you already installed similar constraints, it will update them to achieve your new settings. Of course, you can disable this if you want to install multiple similar constraints of different priority.

When ConstraintKit activates constraints, it always returns the constraints it activated in case you want to keep references to them. In many cases, you won't need to because ConstraintKit is smart about updating existing constrants when possible.

You can also use ConstraintKit to intelligently activate, deactive, and update individual constraints no matter how they were created. Simply use the ```clk_activate``` extension on NSLayoutConstraint.

ConstraintKit always makes sure to turn off ```translatesAutoresizingMaskIntoConstraints``` on the appropriate views.
