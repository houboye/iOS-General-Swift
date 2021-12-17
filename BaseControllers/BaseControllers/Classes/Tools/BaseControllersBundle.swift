//
//  BaseViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit

class BaseControllersBundle {
    static func bundle() -> Bundle? {
        let mainBundle = Bundle(for: BaseViewController.self)
        guard let url = mainBundle.path(forResource: "BaseControllersResources", ofType: "bundle") else {
            return nil
        }
        return Bundle(path: url)
    }
    
    static func image(_ name: String) -> UIImage? {
        return UIImage(named: name, in: bundle(), compatibleWith: nil)
    }
}
