//
//  ATScanQrHandlerProtocol.swift
//  ScanQr
//
//  Created by BY H on 2024/12/2.
//

import UIKit

public protocol BYScanQrHandlerProtocol {
    var showLoading: (() -> Void)? { get set }
    var dismissLoading: (() -> Void)? { get set }
    var showErrorAlert: ((String) -> Void)? { get set }
    var toastError: ((String) -> Void)? { get set }

    func onScanValue(_ value: String, context: UIViewController)
}
