

Pod::Spec.new do |spec|
    spec.name         = "BaseControllers"
    spec.version      = "0.0.1"
    spec.summary      = "BaseControllers for Demo"

    spec.description  = "BaseControllers for Demo"

    spec.homepage     = "https://github.com/houboye/iOS-General-Swift"

    spec.license      = "MIT"

    spec.author       = { "boye" => "boye.hou@gmail.com" }

    spec.platform     = :ios, "13.0"

    spec.source       = { :git => "", :tag => "#{spec.version}" }

    spec.source_files  = "BaseControllers", "BaseControllers/Classes/**/*.swift"

    spec.resources = ["BaseControllers/Resource/**/*"]
    spec.resource_bundles = {
      "BaseControllersResources" => ["BaseControllers/Assets/Main/*.xcassets"]
    }
    
    spec.dependency "GeneralTools"
    spec.static_framework = true
end
