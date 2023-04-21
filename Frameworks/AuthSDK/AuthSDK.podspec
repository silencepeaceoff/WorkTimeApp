Pod::Spec.new do |spec|
  spec.name         = 'AuthSDK'
  spec.version      = '0.1.0'
  spec.license      = 'MCI'
  spec.homepage     = 'https://github.com/silencepeaceoff/AuthSDK'
  spec.authors      = { 'DT' => 'https://github.com/silencepeaceoff/' }
  spec.summary      = 'Description AuthSDK'
  spec.source       = { :git => 'https://github.com/silencepeaceoff/AuthSDK.git', :tag => 'v0.1.0' }
  spec.source_files = '**/*.{swift,h,m,xib,storyboard}'
  spec.resources = [
	"Resources/*.{strings,xcassets,stringsdict}",
	"Resources/**/*.{strings,strigsdict}"
  ]

  spec.ios.deployment_target = '14.0'
  spec.dependency 'R.swift'
  spec.dependency 'UIComponents'
end
