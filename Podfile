# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Propmapped' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Propmapped
  
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'SVProgressHUD'
  pod 'Firebase/Database'
  pod 'Firebase/Messaging'
  pod 'ChameleonFramework'
  pod 'FirebaseUI/Facebook'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'GoogleSignIn'
  pod 'IQKeyboardManagerSwift'
  pod 'Firebase/Storage'
  pod 'SwiftRangeSlider'
  # pod 'Crashlytics'
  # pod 'Fabric'
  pod 'Firebase/Messaging'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'AppAuth'
  pod 'MessageKit'
  pod 'Firebase/Firestore'
  pod "ChatSDK"
  pod "ChatSDKFirebase/Adapter"
  pod "ChatSDKFirebase/FileStorage"
  pod "ChatSDKFirebase/Push"
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end
