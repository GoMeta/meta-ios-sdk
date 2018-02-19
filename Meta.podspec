Pod::Spec.new do |s|
  s.name             = 'Meta'
  s.version          = '0.0.3'
  s.summary          = 'Render Metaverse Experiences in your own apps.'
  s.description      = <<-DESC
Render Metaverse experiences inside of your own app or framework. Build, test, and iterate with Metaverse Studio and Metaverse Browser, and then render in your own app.
                       DESC

  s.homepage         = 'https://gometa.github.io/meta-ios-sdk/Classes/Meta.html'
  s.license          = { :type => 'Custom', :text => 'Copyright 2018 GoMeta' }
  s.author           = { 'Sean Thielen' => 'sean@gometa.io' }

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
  s.dependency 'Zip'
  s.dependency "XCDYouTubeKit", "~> 2.5"
  s.dependency 'ZCAnimatedLabel'
  s.dependency 'GVRSDK-Wrapper'

end
