
Pod::Spec.new do |s|
  s.name             = "RGInputBar"
  s.version          = "0.1.0"
  s.summary          = "Input bar for ruogoo app."
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.description      = <<-DESC
  Input bar for ruogoo app.
                       DESC

  s.homepage         = "https://github.com/HyanCat/RGInputBar"
  s.license          = 'MIT'
  s.author           = { "HyanCat" => "hyancat@live.cn" }
  s.source           = { :git => "https://github.com/HyanCat/RGInputBar.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'RGInputBar/**/*.{h,m}'
  s.public_header_files = 'RGInputBar/**/*.h'
  s.resource = 'RGInputBar/**/*.{bundle,xib}'

  s.dependency  'UITextView+Placeholder'
  s.dependency  'Masonry'

end
