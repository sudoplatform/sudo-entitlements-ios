#
platform :ios, '14.0'

source 'https://github.com/CocoaPods/Specs.git'

workspace 'SudoEntitlements'
use_frameworks!
inhibit_all_warnings!

project 'SudoEntitlements', {
    'Debug-Dev' => :debug,
    'Debug-QA' => :debug,
    'Debug-Prod' => :debug,
    'Release-Dev' => :release,
    'Release-QA' => :release,
    'Release-Prod' => :release
}

target 'SudoEntitlements' do
  inherit! :search_paths
  podspec :name => 'SudoEntitlements'

  target 'SudoEntitlementsTests' do
    podspec :name => 'SudoEntitlements'
  end

  target 'SudoEntitlementsIntegrationTests' do
    podspec :name => 'SudoEntitlements'
    pod 'SudoEntitlementsAdmin'
  end
end

target 'TestApp' do
  inherit! :search_paths
  podspec :name => 'SudoEntitlements'
end

# Fix Xcode nagging warning on pod install/update
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
  end
end
