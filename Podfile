# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

def testing_pods
  pod 'Nimble', '~> 3.2.0 '
end

target 'BirthdaySnap' do
  pod 'Alamofire', '~> 3.2.1'
  pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
  pod 'HanekeSwift'
end

target 'BirthdaySnapTests' do
  testing_pods
end

target 'BirthdaySnapUITests' do
  testing_pods
end
