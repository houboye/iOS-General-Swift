//
//  ScanQrViewController.swift
//  ScanQr
//
//  Created by BY H on 2024/11/26.
//

import UIKit
import AVFoundation

public class BYScanQrViewController: UIViewController, BYScanQrServiceDelegate, TimerHolderDelegate {
    private var coverView: BYScanQrCoverViewProtocol
    private var handler: BYScanQrHandlerProtocol
    private var indicator: BYScanQrIndicatorProtocol
    private var isStopWithResignActive = false
    private let timerHolder = TimerHolder()
    private lazy var scanservice: BYScanQrService = {
        return BYScanQrService(delegate: self)
    }()

    public init(coverView: BYScanQrCoverViewProtocol,
                handler: BYScanQrHandlerProtocol,
                indicator: BYScanQrIndicatorProtocol) {
        self.coverView = coverView
        self.handler = handler
        self.indicator = indicator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        setupCoverView()
        setupHnadler()

        self.scanservice.checkUserDeviceAuth(complete: { [weak self] (grant) in
            guard let self = self else { return }
            self.coverView.onPermissionsStatusChange()
            if grant {
                self.configScanView()
            } else {
                BYScanQrUtils.promptUserDeviceAuth(self,
                                                   indicator: self.indicator)
            }
        })
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        startScan()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopScan()
    }

    private func setupHnadler() {
        handler.triggerStartScan = { [weak self] in
            guard let self = self else { return }
            self.startScan()
        }

        handler.triggerStopScan = { [weak self] in
            guard let self = self else { return }
            self.stopScan()
        }
    }

    private func setupCoverView() {
        view.addSubview(coverView)
        coverView.frame = view.bounds
        coverView.torchStatusSwitch = { [weak self] in
            guard let self = self else { return }
            self.switchFlash()
        }
        coverView.gobackAction = { [weak self] in
            guard let self = self else { return }
            if navigationController == nil {
                dismiss(animated: true, completion: nil)
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }

    private func configScanView() {
        addObserver()
        let prelayer = self.scanservice.prepareReviewLayer { [weak self] () -> CGRect in
            guard let self = self else { return CGRect.zero }
            let rect = self.coverView.interestRect
            let x = rect.minY / UIScreen.main.bounds.height
            let y = rect.minX / UIScreen.main.bounds.width
            let width = rect.height / UIScreen.main.bounds.height
            let height = rect.width / UIScreen.main.bounds.width
            return CGRect(x: x, y: y, width: width, height: height)
        }

        guard let prell = prelayer else { return }

        prell.backgroundColor = UIColor.clear.cgColor
        prell.videoGravity = AVLayerVideoGravity.resizeAspectFill
        prell.frame = view.bounds
        self.view.layer.insertSublayer(prell, at: 0)
    }

    private func startScan() {
        coverView.onStartScan()
        self.scanservice.startScanCode()
        timerHolder.startTimer(seconds: coverView.scanTimeout,
                               delegate: self,
                               repeats: false)
    }

    private func stopScan() {
        coverView.onStopScan()
        self.scanservice.stopScanCode()
        timerHolder.stopTimer()
    }

    public func onTimerFired(_ holder: TimerHolder) {
        coverView.onScanTimeout()
    }

    public func scanservice(barcode: BYScanQrService,
                            scanValue value: String) {
        handler.onScanValue(value,
                            context: self,
                            indicator: self.indicator)
        self.stopScan()
    }

    private func switchFlash() {
        changeLightStatus(!isLightOpen())
    }

    // 手电筒是否可用
    func isTorchAvailable() -> Bool {
        guard let device = scanservice.getDevice() else { return false }
        return device.hasTorch && device.isTorchAvailable
    }

    private func isLightOpen() -> Bool {
        if isTorchAvailable() == false {
            return false
        } else {
            guard let device = scanservice.getDevice() else { return false }
            if device.torchMode == .on {
                return true
            } else {
                return false
            }
        }
    }

    private func changeLightStatus(_ isOpen: Bool) {
        guard let device = scanservice.getDevice() else { return }
        let settings = AVCapturePhotoSettings()
        if isTorchAvailable() == false {
            showAlertErrorMessage("Torch unavailable!")
        } else {
            if isOpen {
                if device.torchMode != .on
                    || settings.flashMode != .on {
                    do {
                        try device.lockForConfiguration()
                        device.torchMode = .on
                        settings.flashMode = .on
                        device.unlockForConfiguration()
                        coverView.onTorchOn()
                    } catch {
                        showAlertErrorMessage(error.localizedDescription)
                    }
                }
            } else {
                if device.torchMode != .off
                    || settings.flashMode != .off {
                    do {
                        try device.lockForConfiguration()
                        device.torchMode = .off
                        settings.flashMode = .off
                        device.unlockForConfiguration()
                        coverView.onTorchOff()
                    } catch {
                        showAlertErrorMessage(error.localizedDescription)
                    }
                }
            }
        }
    }

    @objc func applicationWillResignActive(notification: NSNotification) {
        if self.isViewLoaded && self.view.window != nil {
            coverView.onWillResignActive()
            if scanservice.isRunning {
                isStopWithResignActive = true
                stopScan()
            }
        }
    }

    @objc func applicationDidBecomeActive(notification: NSNotification) {
       if self.isViewLoaded && self.view.window != nil {
           coverView.onDidBecomeActive()
           if isStopWithResignActive {
               isStopWithResignActive = false
               startScan()
           }
       }
    }

    // 用于提示一些系统级别的错误信息
    private func showAlertErrorMessage(_ errorMessage: String) {
        let aciton = BYScanQrIndicatorAclertAction(title: "OK") { [weak self] in
            guard let self = self else { return }
            self.startScan()
        }
        self.indicator.onShowAlert(self,
                                   title: "Error",
                                   message: errorMessage,
                                   actions: [aciton])
    }

    deinit {
        timerHolder.stopTimer()
        debugPrint("BYScanQrViewController deinit")
    }
}
