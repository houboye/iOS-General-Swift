

Pod::Spec.new do |spec|
    spec.name         = "SwiftFormatter"
    spec.version      = "0.0.1"
    spec.summary      = "SwiftFormatter for Swift"

    spec.description  = "SwiftFormatter for Swift"

    spec.homepage     = "https://github.com/houboye/iOS-General-Swift"

    spec.license      = "MIT"

    spec.author       = { "boye" => "boye.hou@gmail.com" }

    spec.platform     = :ios, "13.0"

    spec.source       = { :git => "", :tag => "#{spec.version}" }

    spec.source_files  = "SwiftFormatter", "SwiftFormatter/Classes/**/*.swift"

    spec.resources = ["SwiftFormatter/Resource/**/*"]
    spec.resource_bundles = {
      "SwiftFormatterResources" => ["SwiftFormatter/Assets/Main/*.xcassets"]
    }
    
    spec.static_framework = true
end
