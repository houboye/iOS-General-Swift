

Pod::Spec.new do |spec|
    spec.name         = "GeneralTools"
    spec.version      = "0.0.1"
    spec.summary      = "GeneralTools for Demo"

    spec.description  = "GeneralTools for Demo"

    spec.homepage     = "https://github.com/houboye/iOS-General-Swift"

    spec.license      = "MIT"

    spec.author       = { "boye" => "boye.hou@gmail.com" }

    spec.platform     = :ios, "13.0"

    spec.source       = { :git => "", :tag => "#{spec.version}" }

    spec.source_files  = "GeneralTools", "GeneralTools/Classes/**/*.swift"

    spec.static_framework = true
end
