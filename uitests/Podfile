project 'uitests.xcodeproj'
# Uncomment the next line to define a global platform for your project
 platform :ios, '10.3'
# ignore all warnings from all pods
inhibit_all_warnings!

def shared_pods
  pod 'Alamofire'
  pod 'MaterialComponents/schemes/Typography'
  pod 'MaterialComponents/schemes/Color'
  pod 'SwiftLint'
  pod 'Kingfisher'
  pod 'KeychainSwift'
end

target 'uitests' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for uitests
  shared_pods
  target 'uitestsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'uitestsUITests' do
    # Pods for testing
    inherit! :complete
        # Pods for testing
        shared_pods
        pod 'Embassy', '~> 4.1'
        pod 'EnvoyAmbassador', '~> 4.0'
  end

end
