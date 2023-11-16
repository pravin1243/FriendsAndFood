# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'FriendsAndFoodApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Firebase/Crashlytics'

  # Recommended: Add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'

  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'AZTabBar'
  pod 'SwiftGifOrigin'
  pod 'Kingfisher'
  pod 'SideMenu'
  pod 'SwipeMenuViewController'
  pod 'Cosmos'
  pod 'DropDown'
  pod 'IQKeyboardManagerSwift'
  pod 'TagListView'
  # Pods for FriendsAndFoodApp
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
                  xcconfig_path = config.base_configuration_reference.real_path
                        xcconfig = File.read(xcconfig_path)
                        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
                        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
               end
          end
   end
end

end
