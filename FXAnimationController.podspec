Pod::Spec.new do |s|
  s.name = 'FXAnimationController'
  s.version = '1.0'
  s.summary = 'General purpose animation sequencer'
  s.author = {
    'Mo Bitar' => 'me@bitar.io'
  }
  s.source = {
    :git => 'https://github.com/mobitar/FXAnimationController.git',
    :tag =>  '1.0'
  }
  s.source_files = '/'
  s.ios.frameworks = 'QuartzCore'
end