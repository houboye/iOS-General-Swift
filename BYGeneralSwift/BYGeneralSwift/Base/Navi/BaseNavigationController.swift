//
//  BaseNavigationController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit
/*
 1、关于返回按钮，如果UI只是想要替换系统的icon，需提供合适尺寸的
 */
class BaseNavigationController: UINavigationController {
    enum NavigationBackButtonStyle {
        case style
        case style1
        case style2
        
        var image: UIImage? {
            switch self {
            case .style:
                return UIImage(named: "ic_back")
            case .style1:
                return UIImage(named: "ic_back1")
            case .style2:
                return UIImage(named: "ic_back2")
            }
        }
    }

    // 默认的返回按钮样式
    public var defaultNavigationBackButtonStyle = NavigationBackButtonStyle.style2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = defaultNavigationBackButtonStyle.image
        navigationBar.backIndicatorImage = backImage?.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorTransitionMaskImage = backImage?.withRenderingMode(.alwaysOriginal)
    }
}

extension BaseNavigationController: UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
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
