
Pod::Spec.new do |s|
  s.name             = "HyInputBar"
  s.version          = "0.1.0"
  s.summary          = "Input bar"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.description      = <<-DESC
  Input bar
                       DESC

  s.homepage         = "https://github.com/HyanCat/HyInputBar"
  s.license          = 'MIT'
  s.author           = { "HyanCat" => "hyancat@live.cn" }
  s.source           = { :git => "https://github.com/HyanCat/HyInputBar.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.dependency  'UITextView+Placeholder'

  s.source_files = 'HyInputBar/**/*.{h,m}'
  s.public_header_files = 'HyInputBar/**/*.h'
  s.resource = 'HyInputBar/**/*.{bundle,xib}'

end
