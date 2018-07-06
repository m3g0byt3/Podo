# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '9.3'

target 'Podo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for main target
  pod 'SnapKit', 	'~> 4.0'
  pod 'R.swift', 	'~> 4.0'
  pod 'RxSwift', 	'~> 4.0'
  pod 'RxCocoa', 	'~> 4.0'
  pod 'Swinject', 	'~> 2.0'
  pod 'RealmSwift', 	'~> 3.2'
  pod 'EmptyDataSet-Swift', '~> 4.0.4'
  pod 'RxDataSources', '~> 3.0'
  # pod 'SwiftLint', '~> 0.1'
  # workaround for Xcode 10 beta 3 to use 0.25.1 until 0.26.1 is released
  # https://stackoverflow.com/a/51174106/1033581
  pod 'SwiftLint', '~> 0.25.1'
  
  target 'PodoTests' do
    inherit! :search_paths

    # Pods for testing
    pod 'Quick', 	'~> 1.2'
    pod 'Nimble', 	'~> 7.0'
    pod 'RxBlocking', 	'~> 4.0'
    pod 'RxTest',     	'~> 4.0'

  end

  target 'PodoUITests' do
    inherit! :search_paths

    # Pods for testing
    pod 'Quick', 	'~> 1.2'
    pod 'Nimble', 	'~> 7.0'
    pod 'RxBlocking', 	'~> 4.0'
    pod 'RxTest',     	'~> 4.0'

  end

end
