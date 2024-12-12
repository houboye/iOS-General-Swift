//
//  ScanQrUtils.swift
//  ScanQr
//
//  Created by BY H on 2024/11/27.
//

import UIKit

class BYScanQrUtils {
    static func promptUserDeviceAuth(_ context: UIViewController,
                                     indicator: BYScanQrIndicatorProtocol) {
        let title = "This feature requires camera access"
        let message = "This is required to enable featrue with QR scanning. Go to Settings to turn on access for this featrue."

        let cancelAction = BYScanQrIndicatorAclertAction(title: "Not now") { [weak context] in
            guard let context = context else { return }
            context.navigationController?.popViewController(animated: true)
        }
        let gotoSettingAction = BYScanQrIndicatorAclertAction(title: "Open Settings") {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        indicator.onShowAlert(context,
                              title: title,
                              message: message,
                              actions: [cancelAction, gotoSettingAction])
    }
}
