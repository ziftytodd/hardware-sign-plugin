Pod::Spec.new do |s|
  s.name             = 'hardware-sign-plugin'
  s.version          = '0.0.2'
  s.summary          = 'Hardware-backed signing via Secure Enclave for Capacitor'
  s.homepage         = 'https://github.com/your-org/hardware-sign-plugin'
  s.license          = { :type => 'MIT' }
  s.authors          = { 'Zifty' => 'help@zifty.com' }
  s.platform         = :ios, '13.0'
  s.source           = { :path => '.' }
  s.source_files     = 'Sources/HardwareSignPlugin/**/*.{swift,h,m}'
  s.dependency       'CapacitorCommunity/Capacitor', '~> 6.0'
  s.requires_arc     = true
end
