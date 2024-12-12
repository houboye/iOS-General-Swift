//
//  BYCustomScanQrIndicator.swift
//  BYGeneralSwift
//
//  Created by BY H on 2024/12/12.
//

import UIKit
import PKHUD

public class BYCustomScanQrIndicator: BYScanQrIndicatorProtocol {
    public func onShowLoading(_ context: UIViewController) {
        PKHUD.sharedHUD.show()
    }

    public func onDismissLoading(_ context: UIViewController) {
        PKHUD.sharedHUD.hide(false)
    }

    public func onShowAlert(_ context: UIViewController,
                            title: String?,
                            message: String?,
                            actions: [BYScanQrIndicatorAclertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        actions.forEach { action in
            let action = UIAlertAction(title: action.title, style: .cancel) { [weak self] _ in
                guard let self = self else { return }
                action.handler?()
            }
            alert.addAction(action)
        }

        context.present(alert, animated: true)
    }

    public func onShowToast(_ context: UIViewController, message: String) {
        HUD.flash(.labeledError(title: message, subtitle: nil))
    }
}
