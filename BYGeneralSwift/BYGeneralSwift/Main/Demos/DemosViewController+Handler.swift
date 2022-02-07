//
//  DemosViewController+Handler.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/13.
//

import UIKit
import BaseControllers

extension DemosViewController {
    func handledidSelectRow(_ item: DemoItem) {
        switch item.demoType {
        case .offScreenRendering:
            let viewController = OffScreenRenderingViewController()
            navigationController?.push(viewController: viewController)
        case .VPN:
            let viewController = VPNViewController()
            navigationController?.push(viewController: viewController)
        }
    }
}
