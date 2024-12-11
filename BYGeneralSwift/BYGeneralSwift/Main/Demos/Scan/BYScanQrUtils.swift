//
//  ScanQrUtils.swift
//  ScanQr
//
//  Created by BY H on 2024/11/27.
//

import UIKit

class BYScanQrUtils {
    static func promptUserDeviceAuth(_ context: UIViewController) {
        let title = "This feature requires camera access"
        let message = "This is required to enable featrue with QR scanning. Go to Settings to turn on access for this featrue."
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Not now", style: .default, handler: { [weak context] (_) in
            guard let context = context else { return }
            context.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(cancel)

        let go = UIAlertAction(title: "Open Settings", style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        alertController.addAction(go)

        context.present(alertController, animated: true, completion: nil)
    }
}
