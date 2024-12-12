//
//  ATScanQrService.swift
//  ScanQr
//
//  Created by BY H on 2024/11/26.
//

import UIKit
import AVFoundation

public protocol BYScanQrServiceDelegate: AnyObject {
    func scanservice(barcode: BYScanQrService, scanValue value: String)
}

public class BYScanQrService: NSObject {
    private var captureSession = AVCaptureSession()
    private weak var delegate: BYScanQrServiceDelegate?
    private let qrQueueIdentifier = "com.Paylater.qrscan"

    var isRunning: Bool {
        captureSession.isRunning
    }

    init(delegate: BYScanQrServiceDelegate) {
        self.delegate = delegate
        super.init()
    }

    private func createCaptureDeviceInput() -> AVCaptureDeviceInput? {
        guard let device = getDevice() else {
            return nil
        }

        do {
            return try AVCaptureDeviceInput(device: device)
        } catch {
            return nil
        }
    }

    public func getDevice() -> AVCaptureDevice? {
        let type = AVCaptureDevice.DeviceType.builtInWideAngleCamera
        let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: [type],
                                                         mediaType: AVMediaType.video,
                                                        position: AVCaptureDevice.Position.back)
        return discovery.devices.first
    }

    public func prepareReviewLayer(interestRect: (() -> CGRect)) -> AVCaptureVideoPreviewLayer? {

        guard let captureDeviceInput = createCaptureDeviceInput() else {
            return nil
        }

        if self.captureSession.canSetSessionPreset(AVCaptureSession.Preset.photo) {
            self.captureSession.sessionPreset = AVCaptureSession.Preset.photo
        }
        if self.captureSession.canAddInput(captureDeviceInput) { self.captureSession.addInput(captureDeviceInput) }

        let queue = DispatchQueue(label: qrQueueIdentifier)

        let metadataOutput = AVCaptureMetadataOutput()
        if self.captureSession.canAddOutput(metadataOutput) { self.captureSession.addOutput(metadataOutput)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            metadataOutput.rectOfInterest = interestRect()
            metadataOutput.setMetadataObjectsDelegate(self, queue: queue)
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        return previewLayer
    }

    deinit {
        stopScanCode()
    }

    public func startScanCode() {
        DispatchQueue.global(qos: .background).async {
            if self.captureSession.isRunning == false {
                self.captureSession.startRunning()
            }
        }
    }

    public func stopScanCode() {
        if self.captureSession.isRunning == true {
            self.captureSession.stopRunning()
        }
    }

    public func checkUserDeviceAuth(complete: @escaping ((Bool) -> Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        switch status {
        case .authorized: complete(true)
        case .denied, .restricted: complete(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (grant) in
                DispatchQueue.main.async {
                    complete(grant)
                }
            })
        @unknown default:
            print("unknown")
        }
    }
}

extension BYScanQrService: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        guard let readable = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let value = readable.stringValue else {
            return
        }
        captureSession.stopRunning()
        DispatchQueue.main.async {
            self.delegate?.scanservice(barcode: self, scanValue: value)
        }
    }
}
