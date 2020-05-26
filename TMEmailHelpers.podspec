Pod::Spec.new do |s|

    s.name                    = 'TMEmailHelpers'
    s.version                 = '2.0.0'
    s.summary                 = 'Email creation helpers'

    s.homepage                = 'http://github.com/hiimtmac/TMEmailHelpers'
    s.license                 = { :type => 'MIT', :file => 'LICENSE' }

    s.author                  = 'Taylor McIntyre'
    s.social_media_url        = 'http://twitter.com/hiimtmac'
    s.ios.deployment_target   = '13.1'
    s.swift_version           = '5.2'

    s.source                  = { :git => 'https://github.com/hiimtmac/TMEmailHelpers.git', :tag => s.version }
    s.source_files            = 'Sources/TMEmailHelpers/**/*.swift'
    s.requires_arc            = true
    s.framework               = 'MessageUI'
    
end
