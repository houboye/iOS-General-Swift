import Foundation

final public class BundleTools {
    public static func bundle(for clazz: AnyClass, resourcesName: String) -> Bundle? {
        let mainBundle = Bundle(for: clazz)
        guard let path = mainBundle.path(forResource: resourcesName, ofType: "bundle") else {
            return nil
        }
        return Bundle(path: path)
    }
    
    public static func image(_ name: String, in bundle: Bundle?) -> UIImage? {
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}
