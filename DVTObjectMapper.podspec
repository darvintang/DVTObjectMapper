Pod::Spec.new do |s|
  s.name             = 'DVTObjectMapper'
  s.version          = '4.2.1'
  s.summary          = 'DVTObjectMapper'

  s.description      = <<-DESC
  TODO:
  DVTObjectMapper 是一个使用 Swift 编写的用于 model 对象（类和结构体）和 JSON  之间转换的框架。
  是ObjectMapper的扩展，使数据解析有了更好的兼容性
  DESC

  s.homepage         = 'https://github.com/darvintang/DVTObjectMapper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xt-input' => 'input@tcoding.cn' }
  s.source           = { :git => 'https://github.com/darvintang/DVTObjectMapper.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'

  s.source_files = 'Sources/*.swift','Sources/Extension/*.swift'

  s.swift_version = '5'
  s.requires_arc  = true
end
