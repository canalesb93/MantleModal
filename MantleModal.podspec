#
#  Be sure to run `pod spec lint Mantle.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "MantleModal"
  s.version      = "0.0.3"
  s.summary      = "A simple modal closable by dragging."                   
  s.description      = <<-DESC
                        A simple modal resource that uses a UIScrollView to allow the user to close the modal by dragging it down.
                       DESC
  s.homepage     = "https://github.com/canalesb93/MantleModal"
  s.screenshots  = "http://imgur.com/tZr1ns4.gif"
  s.license      = { :type => 'MIT' }
  s.author       = { "Ricardo Canales" => "canalesb93@gmail.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/canalesb93/MantleModal.git", :tag => s.version.to_s }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
