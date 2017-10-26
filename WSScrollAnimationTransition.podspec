
Pod::Spec.new do |s|

  s.name             = "WSScrollAnimationTransition"
  s.version          = "0.0.1"
  s.summary          = "水平/左右滑动的交互转场动画,通过该转场动画可将UITabBarController作为容器,实现类似天猫商品详情页的效果."
  s.homepage         = "https://github.com/ONECATYU/WSScrollAnimationTransition"
  # s.screenshots    = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "ONECATYU" => "786910875@qq.com" }
  s.platform         = :ios, "8.0"
  s.source           = { :git => "https://github.com/ONECATYU/WSScrollAnimationTransition.git", :tag => s.version.to_s }
  s.source_files     = "WSScrollAnimationTransition", "WSScrollAnimationTransition/**/*.{h,m}"
  s.frameworks       = "UIKit", "Foundation"
  s.requires_arc     = true

end
