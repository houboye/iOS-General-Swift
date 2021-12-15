//
//  DemosViewController+Handler.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/13.
//

import UIKit

extension DemosViewController {
    func handledidSelectRow(_ item: DemoItem) {
        switch item.demoType {
        case .offScreenRendering:
            let viewController = OffScreenRenderingViewController()
            navigationController?.push(viewController: viewController)
        }
    }
}
