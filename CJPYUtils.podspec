Pod::Spec.new do |s|
  s.name         = "CJPYUtils"
  s.version      = "0.0.1"
  s.summary      = "Some Utils classes. "
  s.homepage     = ""
  s.license      = 'MIT'
  s.author       = { "CJPY Studio" => "cjpystudio@gmail.com" }
 
  s.requires_arc = true
  s.dependency 'JSONKit'
  s.dependency 'NullSafe'
  s.dependency 'BlocksKit'
  s.dependency 'iRate'
  s.dependency 'iVersion'
  s.dependency 'iNotify'  
  s.dependency 'MagicalRecord'
  s.dependency 'ASIHTTPRequest'
  s.dependency 'Slash'
  
  s.ios.source_files = "Utils/ios/**/*.{h,m}","Utils/CJPYUtilsHeaders.h",'Utils/models/**/*.{h,m}','Utils/services/**/*.{h,m}','Utils/utils/**/*.{h,m}','Utils/CJPYUtilsGlobals.h','Utils/DependLibHeaders.h'
  s.ios.deployment_target = "6.0"
  s.ios.dependency 'OHAttributedLabel'
  s.ios.dependency 'MBProgressHUD'
  s.ios.dependency 'SDWebImage'
  s.ios.dependency 'SFHFKeychainUtils'  
  
  s.osx.source_files = "Utils/osx/**/*.{h,m}",'Utils/models/**/*.{h,m}','Utils/services/**/*.{h,m}','Utils/utils/**/*.{h,m}','Utils/CJPYUtilsGlobals.h','Utils/DependLibHeaders.h'
  s.osx.deployment_target = "10.7"

end
