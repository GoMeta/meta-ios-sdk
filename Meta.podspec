Pod::Spec.new do |s|
  s.name             = 'Meta'
  s.version          = '0.0.1'
  s.summary          = 'A short description of Meta.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sean Thielen/Meta'
  s.license          = { :type => 'Custom', :text => 'Copyright 2018 GoMeta' }
  s.author           = { 'Sean Thielen' => 'sean@p27.us' }

  s.platform         = :ios, "9.3"
  s.swift_version    = '4.0'
  s.source           = { :git => "https://github.com/GoMeta/meta-ios-sdk.git", :tag => "#{s.version}" }

  s.ios.vendored_frameworks = 'Meta.framework'

  s.frameworks = [
    'Foundation',
    'UIKit',
    'CoreLocation',
    'AVFoundation',
    'SafariServices',
    'Webkit',
    'ARKit',
    'SceneKit',
    'ModelIO',
    'SpriteKit',
    'CoreMotion',
    'Photos',
    'CoreMedia',
    'ImageIO',
    'AudioToolbox'
  ]

  s.dependency "Alamofire", "~> 4.0"
  s.dependency "AWSS3"
  s.dependency "SwiftyJSON"
  s.dependency "iCarousel"
  s.dependency 'Kingfisher', '~> 4.0'
  s.dependency 'pop'
  s.dependency 'Zip'
  s.dependency "XCDYouTubeKit", "~> 2.5"
  s.dependency 'ZCAnimatedLabel'
  s.dependency 'GVRSDK-Wrapper'

end
