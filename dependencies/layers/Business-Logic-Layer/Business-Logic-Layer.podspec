
Pod::Spec.new do |s|
  s.name     = 'Business-Logic-Layer'
  s.version  = '0.1.0'
  s.license  = 'MIT'
  s.summary  = 'Business-Logic-Layer aims to be a drop-in replacement for UITabBarController.' 
  s.description = 'Business-Logic-Layer aims to be a drop-in replacement of UITabBarController with the intention of letting developers easily customise its appearance. JBTabBar uses .'
  s.homepage = 'http://www.github.com/wanghaogithub720'
  s.author   = { 'Jin Budelmann' => 'jin@bitcrank.com' }
  s.source   = { :git => 'https://github.com/wanghaogithub720/mxYoutube.git', :tag => '0.1.0' }
  s.platform = :ios

  #s.source_files = 'Pod/Classes/*.{h,m}'

  s.resources = "Pod/Assets/*/*.*"
  s.requires_arc = true

  s.subspec 'datastore' do |sub|
    sub.source_files = 'Pod/Classes/datastore/*.{h,m}'
  end

  s.subspec 'resolution' do |sub|
    sub.source_files = 'Pod/Classes/resolution/*.{h,m}'
  end

  s.subspec 'youtube' do |sub|
    sub.source_files = 'Pod/Classes/youtube/*.{h,m}'
  end

  s.subspec 'LeftReveal' do |sub|
    sub.source_files = 'Pod/Classes/LeftReveal/*.{h,m}'
  end


end

