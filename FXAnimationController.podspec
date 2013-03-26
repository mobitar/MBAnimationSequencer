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
  s.source_files = 'FXAnimationController'
  s.ios.frameworks = 'QuartzCore'
  
  s.subspec 'Categories' do |os|
    os.header_dir     = 'FXAnimationController/Categories'
    os.source_files   = 'FXAnimationController/Categories'
  end
  
  s.subspec 'Store' do |ss|
    ss.header_dir     = 'FXAnimationController/Store'
    ss.source_files   = 'FXAnimationController/Store'
  end
  
  s.subspec 'Utilities' do |us|
    us.header_dir     = 'FXAnimationController/Utilities'
    us.source_files   = 'FXAnimationController/Utilities'
  end
  
end
