//
//  ATScanQrHandlerProtocol.swift
//  ScanQr
//
//  Created by BY H on 2024/12/2.
//

import UIKit

public protocol BYScanQrHandlerProtocol {
    var triggerStartScan: (() -> Void)? { get set }
    var triggerStopScan: (() -> Void)? { get set }

    func onScanValue(_ value: String,
                     context: UIViewController,
                     indicator: BYScanQrIndicatorProtocol)
}
