Pod::Spec.new do |spec|
  spec.name         = 'UIComponents'
  spec.version      = '0.1.0'
  spec.license      = 'MCI'
  spec.homepage     = 'https://github.com/silencepeaceoff/UIComponents'
  spec.authors      = { 'DT' => 'https://github.com/silencepeaceoff/' }
  spec.summary      = 'Description UIComponents'
  spec.source       = { :git => 'https://github.com/silencepeaceoff/UIComponents.git', :tag => 'v0.1.0' }
  spec.source_files = '**/*.{swift,h,m,xib,storyboard}'
  spec.resources = [
	"Resources/*.{strings,xcassets,stringsdict}",
	"Resources/**/*.{strings,strigsdict}"
  ]

  spec.ios.deployment_target = '14.0'
  spec.dependency 'SnapKit'
  spec.dependency 'R.swift'

  spec.script_phase = {
    :name => 'Generate R',
    :script => '"$PODS_ROOT/R.swift/rswift" generate --accessLevel public "$PODS_TARGET_SRCROOT/Resources/Generated/R.generated.swift"',
    :input_files => [ '$TEMP_DIR/rswift-lastrun' ],
    :output_files => [ '$PODS_TARGET_SRCROOT/Resources/Generated/R.generated.swift' ],
    :execution_position => :before_compile
  }

end
