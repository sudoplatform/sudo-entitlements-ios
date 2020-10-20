#
Pod::Spec.new do |spec|
  spec.name                  = 'SudoEntitlements'
  spec.version               = '1.0.0'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com'

  spec.summary               = 'Entitlements SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }

  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-entitlements-ios.git', :tag => "v#{spec.version}" }
  spec.source_files          = 'SudoEntitlements/**/*.swift'
  spec.ios.deployment_target = '11.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'

  spec.dependency 'AWSAppSync', '~> 3.1'
  spec.dependency 'SudoUser', '~> 7.9'
  spec.dependency 'SudoProfiles', '~> 5.4'
  spec.dependency 'SudoLogging', '~> 0.2'
  spec.dependency 'SudoKeyManager', '~> 1.0'
  spec.dependency 'SudoOperations', '~> 3.1'
  spec.dependency 'SudoApiClient', '~> 1.3'
end