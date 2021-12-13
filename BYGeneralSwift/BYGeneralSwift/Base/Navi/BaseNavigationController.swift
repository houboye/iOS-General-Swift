//
//  BaseNavigationController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseNavigationController: UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        debugPrint("------------shouldPush-------------")
        debugPrint(topViewController as Any)
        debugPrint("------------shouldPush-------------")
        return true
    }
    
    // 此方法不靠谱，只会在点击返回按钮的时候触发，手势返回不会触发
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        debugPrint("------------shouldPop-------------")
        debugPrint(topViewController as Any)
        debugPrint("------------shouldPop-------------")
        return true
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        debugPrint("------------didPush-------------")
        debugPrint(topViewController as Any)
        debugPrint("------------didPush-------------")
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        debugPrint("------------didPop-------------")
        debugPrint(topViewController as Any)
        debugPrint("------------didPop-------------")
    }
}
