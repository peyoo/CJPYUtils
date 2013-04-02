Pod::Spec.new do |s|
  s.name         = "CJPYUtils"
  s.version      = "0.0.1"
  s.summary      = "Some Utils classes. "
  s.homepage  = ""
  s.license      = 'MIT'
  s.author       = { "CJPY Studio" => "cjpystudio@gmail.com" }
  #s.source       = { :git => "https://github.com/500px/500px-iOS-api.git", :tag => "1.0.2" }
  s.platform     = :ios, '6.0'
  s.source_files = 'Classes', 'Utils/**/*.{h,m}'
  s.requires_arc = true
end
