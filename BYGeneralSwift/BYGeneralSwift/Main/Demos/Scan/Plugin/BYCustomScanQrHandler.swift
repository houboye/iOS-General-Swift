//
//  ATPHCardScanQrHandler.swift
//  ScanQr
//
//  Created by BY H on 2024/12/2.
//

import UIKit

public class BYCustomScanQrHandler: BYScanQrHandlerProtocol {
    public var triggerStartScan: (() -> Void)?

    public var triggerStopScan: (() -> Void)?

    public func onScanValue(_ value: String,
                            context: UIViewController,
                            indicator: BYScanQrIndicatorProtocol) {
        let action = BYScanQrIndicatorAclertAction(title: "OK") { [weak self] in
            guard let self = self else { return }
            self.triggerStartScan?()
        }

        indicator.onShowAlert(context,
                              title: "Success",
                              message: value,
                              actions: [action])
    }
}
