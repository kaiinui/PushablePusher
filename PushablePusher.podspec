Pod::Spec.new do |s|
  s.name         = "PushablePusher"
  s.version      = "0.1.0"
  s.summary      = "[iOS] PushablePusher"
  s.homepage     = "https://github.com/kaiinui/PushablePusher"
  s.license      = "MIT"
  s.author       = { "kaiinui" => "lied.der.optik@gmail.com" }
  s.source       = { :git => "https://github.com/kaiinui/PushablePusher.git", :tag => "v0.1.0" }
  s.source_files  = "PushablePusher/Classes/**/*.{h,m}"
  s.requires_arc = true
  s.platform = "ios", '7.0'
end
