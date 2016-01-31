
Pod::Spec.new do |s|

  s.name         = "ConstraintKit"
  s.version      = "0.0.1"
  s.summary      = "Activate, deactivate, and update multiple layout constraints in a single line"
  s.description  = <<-DESC
                   ConstraintKit makes it easy to activate, deactivate, and update layout constraints on iOS in Swift and Objective-C. It intelligently disables translatesAutoresizingMaskIntoConstraints on views participating in auto-layout, lets you update installed constraints without storing references to them, and lets you activate individual constraints in a single line of code, but it's most powerful feature is that it lets define the layout for an entire view in just one line.
                   DESC
  s.homepage     = "https://github.com/jedlewison/ConstraintKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jed Lewison" => "jed@magicappfactory.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/jedlewison/ConstraintKit.git", :tag => "#{s.version}" }
  s.source_files  = "ConstraintKit/**/*.{swift}"
  s.framework  = "UIKit"


end
