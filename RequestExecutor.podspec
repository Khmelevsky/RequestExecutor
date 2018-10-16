Pod::Spec.new do |s|
  s.name           = 'RequestExecutor'
  s.version        = '1.0'
  s.summary        = "Request executor"
  s.homepage       = "https://github.com/Khmelevsky/RequestExecutor"
  s.author         = { 'Alexandr Khmelevsky' => 'khmelevsky.alex@gmail.com' }
  s.social_media_url   = "https://twitter.com/AlexKhmelevsky"
  s.source         = { :git => 'https://github.com/Khmelevsky/RequestExecutor.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.requires_arc   = true
  s.source_files   = 'Sources/**/*.swift'
  s.license        = 'MIT'
end
