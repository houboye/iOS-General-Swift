//
//  BYScanQrIndicatorProtocol.swift
//  BYGeneralSwift
//
//  Created by BY H on 2024/12/12.
//

import UIKit

public struct BYScanQrIndicatorAclertAction {
    var title: String
    var handler: (() -> Void)?

    public init(title: String,
                handler: (() -> Void)?) {
        self.title = title
        self.handler = handler
    }
}

public protocol BYScanQrIndicatorProtocol {
    func onShowLoading(_ context: UIViewController)

    func onDismissLoading(_ context: UIViewController)

    func onShowAlert(_ context: UIViewController,
                     title: String?,
                     message: String?,
                     actions: [BYScanQrIndicatorAclertAction])

    func onShowToast(_ context: UIViewController,
                     message: String)
}
