//
//  PromiseKitViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/7/14.
//

import UIKit
import PromiseKit

class PromiseKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = hungry()
        
    }
    
    func hungry() -> Promise<Void> {
        return cook()
            .then(eat)
            .then(wash)
            .done { data in
                print(data)
            }
    }
    
    func cook() -> Promise<String> {
        print("开始做饭")
        return Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("做饭完毕！")
                resolver.fulfill("鸡蛋炒饭")
            }
        }
    }
    
    func eat(_ dishName: String) -> Promise<String> {
        print("开始吃饭L: \(dishName)")
        return Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("吃饭完毕！")
                resolver.fulfill("一个碗和一双筷子")
            }
        }
    }
    
    func wash(_ kitchenUtensils: String) -> Promise<String> {
        print("开始洗碗：\(kitchenUtensils)")
        return Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("洗碗完毕")
                resolver.fulfill("干净的碗筷")
            }
        }
    }
}
