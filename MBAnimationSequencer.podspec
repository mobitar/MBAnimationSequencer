Pod::Spec.new do |s|
  s.name = 'MBAnimationSequencer'
  s.version = '1.0'
  s.summary = 'General purpose animation sequencer'
  s.author = {
    'Mo Bitar' => 'me@bitar.io'
  }
  s.source = {
    :git => 'https://github.com/mobitar/MBAnimationSequencer.git',
    :tag =>  '1.0'
  }
  s.source_files = 'MBAnimationSequencer'
  s.ios.frameworks = 'QuartzCore'
  
  s.subspec 'Categories' do |os|
    os.header_dir     = 'MBAnimationSequencer/Categories'
    os.source_files   = 'MBAnimationSequencer/Categories'
  end
  
  s.subspec 'Store' do |ss|
    ss.header_dir     = 'MBAnimationSequencer/Store'
    ss.source_files   = 'MBAnimationSequencer/Store'
  end
  
  s.subspec 'Utilities' do |us|
    us.header_dir     = 'MBAnimationSequencer/Utilities'
    us.source_files   = 'MBAnimationSequencer/Utilities'
  end
  
end
