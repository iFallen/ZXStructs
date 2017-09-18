Pod::Spec.new do |s|
  s.name             = 'ZXStructs'
  s.version          = '0.9.3'
  s.summary          = 'ZXStructs.For iOS Common UI Config'

  s.description      = <<-DESC
  ZXStructs.For iOS Common UI Config.
                       DESC

  s.homepage         = 'https://github.com/iFallen/ZXStructs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iFallen' => 'hulj1204@yahoo.com' }
  s.source           = { :git => 'https://github.com/iFallen/ZXStructs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files          = 'ZXStructs/**/*.swift'
  s.resource              = 'ZXStructs/ZXSettings.bundle'
  # s.dependency            'ZXAutoScrollView'
end
