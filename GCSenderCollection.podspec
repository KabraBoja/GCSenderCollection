Pod::Spec.new do |s|
  s.name         = 'GCSenderCollection'
  s.version      = '1.0.0'
  s.summary      = 'A class that acts as a NSDictionary able to accept objects as keys using (hash generation). It also can use weak references to avoid cyclic references.'
  s.author = {
    'Eloi Guzmán Cerón' => ''
  }
  s.platform = :ios
  s.source  = { 
    :git => 'https://github.com/KabraBoja/GCSenderCollection.git', :tag => '1.0.0'
  }
  s.source_files = 'src/*.{h,m}'
  s.requires_arc = true
end