Pod::Spec.new do |s|

    s.name                  = 'RPiOSFeedback'
    s.version               = '0.0.4'
    s.summary               = 'RPiOSFeedback'
    s.description           = <<-DESC
    This is the ReviewPush feedback SDK.
    DESC

    s.homepage              = 'https://github.com/mtorcutt/RPiOSFeedback'
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.author                = { 'Michael Orcutt' => 'michaeltorcutt@gmail.com' }
    s.source                = { :git => 'https://github.com/mtorcutt/RPiOSFeedback.git', :tag => s.version.to_s }
    s.ios.deployment_target = '10.0'
    s.source_files          = 'RPiOSFeedback/**/*.{swift}'
    s.resources             = 'RPiOSFeedback/**/*.{png,jpeg,jpg,storyboard,xib}'
    s.requires_arc          = true

    s.dependency 'Alamofire'

    s.resource_bundles = {
        'RPiOSFeedback' => ['RPiOSFeedback/**/*.{png,jpeg,jpg,storyboard,xib}']
    }

end
