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
public class NavigationController: UINavigationController {
    public enum NavigationBackButtonStyle {
        case style
        case style1
        case style2
        
        var image: UIImage? {
            switch self {
            case .style:
                return BaseControllersBundle.image("ic_back")
            case .style1:
                return BaseControllersBundle.image("ic_back1")
            case .style2:
                return BaseControllersBundle.image("ic_back2")
            }
        }
    }

    // 默认的返回按钮样式
    public var defaultNavigationBackButtonStyle = NavigationBackButtonStyle.style2
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = defaultNavigationBackButtonStyle.image
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance.init()
            appearance.setBackIndicatorImage(backImage?.withRenderingMode(.alwaysOriginal), transitionMaskImage: backImage?.withRenderingMode(.alwaysOriginal))
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationBar.backIndicatorImage = backImage?.withRenderingMode(.alwaysOriginal)
            navigationBar.backIndicatorTransitionMaskImage = backImage?.withRenderingMode(.alwaysOriginal)
        }
        navigationBar.tintColor = UIColor.systemBlue
        navigationBar.barStyle = .default
    }
}

extension NavigationController: UINavigationBarDelegate {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        item.backBarButtonItem = backButton
        
        return true
    }
    
    // 此方法不靠谱，只会在点击返回按钮的时候触发，手势返回不会触发
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        
    }
}
