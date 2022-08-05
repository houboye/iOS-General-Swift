//
//  BaseViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import GeneralTools

class BaseControllersBundle {
    static func bundle() -> Bundle? {
        return BundleTools.bundle(for: BaseViewController.self, resourcesName: "BaseControllersResources")
    }

    static func image(_ name: String) -> UIImage? {
        return BundleTools.image(name, in: bundle())
    }
}
