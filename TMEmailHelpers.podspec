Pod::Spec.new do |s|

    s.name                    = 'TMEmailHelpers'
    s.version                 = '1.2.1'
    s.summary                 = 'Email creation helpers'

    s.homepage                = 'http://github.com/hiimtmac/TMEmailHelpers'
    s.license                 = { :type => 'MIT', :file => 'LICENSE' }

    s.author                  = 'Taylor McIntyre'
    s.social_media_url        = 'http://twitter.com/hiimtmac'
    s.ios.deployment_target   = '11.0'
    s.swift_version           = '5.0'

    s.source                  = { :git => 'https://github.com/hiimtmac/TMEmailHelpers.git', :tag => s.version }
    s.source_files            = 'TMEmailHelpers/**/*.swift'
    s.requires_arc            = true
    s.framework               = 'MessageUI'

    s.dependency 'SwiftyMimes'
end
