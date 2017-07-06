Pod::Spec.new do |s|
  s.name             = 'ZXStructs'
  s.version          = '0.9.0'
  s.summary          = 'A short description of ZXStructs.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/iFallen/ZXStructs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iFallen' => 'hulj1204@yahoo.com' }
  s.source           = { :git => 'https://github.com/iFallen/ZXStructs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files          = 'ZXStructs/**/*.swift'
  s.resource              = 'ZXStructs/ZXSettings.bundle'
  s.public_header_files   = 'ZXStructs/*.h'
end
