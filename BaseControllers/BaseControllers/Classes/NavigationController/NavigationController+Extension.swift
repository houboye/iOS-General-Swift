//
//  BaseNavigationController+Extension.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/15.
//

import UIKit

public extension UINavigationController {
    func push(viewController: UIViewController, hidesBottomBarWhenPushed: Bool = true, animated: Bool = true) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        pushViewController(viewController, animated: animated)
    }
}
