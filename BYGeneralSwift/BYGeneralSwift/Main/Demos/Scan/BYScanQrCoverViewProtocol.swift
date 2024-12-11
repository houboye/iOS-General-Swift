//
//  ScanQrControllerProtocol.swift
//  ScanQr
//
//  Created by BY H on 2024/12/2.
//

import UIKit

public protocol BYScanQrCoverViewProtocol: UIView {
    // 扫描区域
    var interestRect: CGRect { get }
    // 扫描超时时长
    var scanTimeout: TimeInterval { get }
    // 切换手电筒
    var torchStatusSwitch: (() -> Void)? { get set }
    // 返回按钮
    var gobackAction: (() -> Void)? { get set }
    // 开始扫码回调
    func onStartScan()
    // 停止扫码回调
    func onStopScan()
    // 手电筒打开回调
    func onTorchOn()
    // 手电筒关闭回调
    func onTorchOff()
    // 切换至前台
    func onDidBecomeActive()
    // 切换至后台
    func onWillResignActive()
    // 权限状态改变
    func onPermissionsStatusChange()
    // 扫描超时回调
    func onScanTimeout()
}
