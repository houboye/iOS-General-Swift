//
//  ATPHCardScanQrHandler.swift
//  ScanQr
//
//  Created by BY H on 2024/12/2.
//

import UIKit

public class BYPHCardScanQrHandler: BYScanQrHandlerProtocol {
    public var showLoading: (() -> Void)?

    public var dismissLoading: (() -> Void)?

    public var showErrorAlert: ((String) -> Void)?

    public var toastError: ((String) -> Void)?

    public func onScanValue(_ value: String, context: UIViewController) {
        showAlertMessage(value, context: context)
    }

    private func showAlertMessage(_ message: String, context: UIViewController) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        context.present(alert, animated: true)
    }
}
