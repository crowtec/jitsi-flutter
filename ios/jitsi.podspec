#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint jitsi.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'jitsi'
  s.version          = '0.0.1'
  s.summary          = 'Jitsi Meet Flutter Plugin.'
  s.description      = <<-DESC
Jitsi Meet for flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Crowtec' => 'info@crowtec.co' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'JitsiMeetSDK', '5.1.1'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
