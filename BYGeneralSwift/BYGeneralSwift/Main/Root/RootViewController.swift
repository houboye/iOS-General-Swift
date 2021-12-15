//
//  RootViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit
import BaseControllers

enum TabBarType: Int {
    case Home = 0
    case Demos
}

fileprivate let TabbarVC = "vc"
fileprivate let TabbarTitle = "title"
fileprivate let TabbarImage = "image"
fileprivate let TabbarSelectedImage = "selectedImage"
fileprivate let TabbarItemBadgeValue = "badgeValue"
fileprivate let TabBarCount = 2

class RootViewController: UITabBarController {

//    private(set) var navigationHandlers = [NavigationHandler]()

    func instance() -> RootViewController? {
        let delegate = UIApplication.shared.delegate
        if let vc = delegate?.window??.rootViewController {
            if vc.isKind(of: RootViewController.self) {
                return vc as? RootViewController
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tabBar.backgroundColor = UIColor.systemGray6
        setupSubNavigationController()
    }
    
    private func setupSubNavigationController() {
        tabbars().forEach { obj in
            let type = obj
            let item = self.vcInfo(for: type)
            let vcName = item[TabbarVC] as! String
            let title = item[TabbarTitle] as! String
            let imageName = item[TabbarImage] as! String
            let imageSelected = item[TabbarSelectedImage] as! String
            
            let clazz = NSClassFromString(vcName) as! UIViewController.Type
            let vc = clazz.init()
            
            _ = setupChildViewController(vc, title: title, image: imageName, selectedImage: imageSelected)
        }
//        let handlerArray = tabbars().compactMap { (obj) -> NavigationHandler in
//            let type = obj
//            let item = self.vcInfo(for: type)
//            let vcName = item[TabbarVC] as! String
//            let title = item[TabbarTitle] as! String
//            let imageName = item[TabbarImage] as! String
//            let imageSelected = item[TabbarSelectedImage] as! String
//
//            let clazz = NSClassFromString(vcName) as! UIViewController.Type
//            let vc = clazz.init()
//
//            let nc = setupChildViewController(vc, title: title, image: imageName, selectedImage: imageSelected)
//            let handler = NavigationHandler(navigationController: nc)
//            nc.delegate = handler
//
//            return handler
//        }
//        navigationHandlers = handlerArray
    }
    
    private func tabbars() -> [TabBarType] {
        var items = [TabBarType]()
        for index in 0..<TabBarCount {
            items.append(TabBarType(rawValue: index)!)
        }
        return items
    }
    
    private func setupChildViewController(_ viewController: UIViewController, title: String, image: String, selectedImage: String) -> UINavigationController {
        viewController.title = title
        let nc = NavigationController(rootViewController: viewController)
        
        var bgImage = UIImage(named: image)
        bgImage = bgImage?.withRenderingMode(.alwaysOriginal)
        var bgSelectedImage = UIImage(named: selectedImage)
        bgSelectedImage = bgSelectedImage?.withRenderingMode(.alwaysOriginal)
        
        nc.tabBarItem.image = bgImage
        nc.tabBarItem.selectedImage = bgSelectedImage
        nc.tabBarItem.title = title
        nc.tabBarItem.imageInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        
        addChild(nc)
        
        return nc
    }
    
    private func vcInfo(for tabType: TabBarType) -> [String: Any] {
        
        let congfig = [TabBarType.Home: [TabbarVC: NSStringFromClass(HomeViewController.self),
                                            TabbarTitle: "Home",
                                            TabbarImage: "B1",
                                            TabbarSelectedImage: "A1"],
                       
                       TabBarType.Demos: [TabbarVC: NSStringFromClass(DemosViewController.self),
                                                TabbarTitle: "Demos",
                                                TabbarImage: "B2",
                                                TabbarSelectedImage: "A2"]]
        
        return congfig[tabType]!
    }
}
