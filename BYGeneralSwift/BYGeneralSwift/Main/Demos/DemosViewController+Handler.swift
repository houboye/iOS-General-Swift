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
        case .linkedList:
            let viewController = SwiftListNodeViewController()
            navigationController?.push(viewController: viewController)
        case .promiseKit:
            let viewController = PromiseKitViewController()
            navigationController?.push(viewController: viewController)
        case .format:
            let viewController = FormatIndexViewController()
            navigationController?.push(viewController: viewController)
        case .Scan:
            let c = BYCustomScanQrCoverView()
            let h = BYCustomScanQrHandler()
            let i = BYCustomScanQrIndicator()
            let vc = BYScanQrViewController(coverView: c,
                                            handler: h, indicator: i)
            navigationController?.push(viewController: vc)
        }
    }
}
