//
//  ATPHCardScanQrCoverView.swift
//  ScanQr
//
//  Created by BY H on 2024/12/2.
//

import UIKit

public class BYCustomScanQrCoverView: UIView,
                                      BYScanQrCoverViewProtocol {
    public var scanTimeout: TimeInterval {
        return 5
    }

    public var interestRect: CGRect {
        let x: CGFloat = 60
        let width = UIScreen.main.bounds.width - 120
        let y = (UIScreen.main.bounds.height - UIScreen.main.bounds.width) / 2
        let height = width
        return CGRect(x: x, y: y, width: width, height: height)
    }

    public var torchStatusSwitch: (() -> Void)?
    public var gobackAction: (() -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    private lazy var lineLayer: CAShapeLayer = {
        let windowLayer = CAShapeLayer.init()
        windowLayer.frame = CGRect.zero
        windowLayer.borderColor = UIColor.white.cgColor
        windowLayer.borderWidth = 1
        return windowLayer
    }()
    private let lineWidth: CGFloat = 2
    private let lineLength: CGFloat = 24
    private let scannerLineHeight: CGFloat = 64
    /** 扫描线条 */
    private lazy var scannerLine: UIImageView = {
        let scannerLineWidth = interestRect.width
        let tempScannerLine = UIImageView(frame: CGRect(x: interestRect.minX, y: interestRect.minY, width: scannerLineWidth, height: scannerLineHeight))
        tempScannerLine.image = UIImage(named: "ic_qr_scanner_line")
        return tempScannerLine
    }()
    private let scannerLineAnmationKey = "ScannerLineAnmationKey"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupMaskLayer()
        addBorderLine()
        addSubview(scannerLine)
    }

    /** 添加扫描线条动画 */
    private func addScannerLineAnimation() {
        // 若已添加动画，则先移除动画再添加
        self.scannerLine.isHidden = false
        self.scannerLine.layer.removeAllAnimations()

        let lineAnimation = CABasicAnimation(keyPath: "transform")
        lineAnimation.toValue = NSValue(caTransform3D: CATransform3DMakeTranslation(0, interestRect.height - scannerLineHeight, 1))
        lineAnimation.duration = 4
        lineAnimation.repeatCount = MAXFLOAT
        lineAnimation.isRemovedOnCompletion = false
        lineAnimation.fillMode = .forwards
        self.scannerLine.layer.add(lineAnimation, forKey: scannerLineAnmationKey)
        // 重置动画运行速度
        self.scannerLine.layer.speed = 1.5
    }

    /** 暂停扫描器动画 */
    private func pauseScannerLineAnimation() {
        // 取出当前时间，转成动画暂停的时间
        self.scannerLine.isHidden = true
        let pauseTime = self.scannerLine.layer.convertTime(CACurrentMediaTime(), from: nil)
        // 设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
        self.scannerLine.layer.timeOffset = pauseTime
        // 将动画的运行速度设置为0， 默认的运行速度是1.0
        self.scannerLine.layer.speed = 0
    }

    private func setupMaskLayer() {
        let bezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let subPath = UIBezierPath(roundedRect: interestRect, cornerRadius: 0).reversing()

        bezierPath.append(subPath)

        let maskLayer = CAShapeLayer()
        maskLayer.path = bezierPath.cgPath
        maskLayer.fillRule = .evenOdd
        maskLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        layer.addSublayer(maskLayer)
    }

    private func addBorderLine(borderColor: UIColor = .lightGray, cornerColor: UIColor = .white) {
        let borderWidth: CGFloat = 1
        lineLayer.frame = interestRect

        let windowLayerWidth =  self.lineLayer.frame.size.width
        let windowLayerHeight =  self.lineLayer.frame.size.height

        lineLayer.sublayers?.enumerated().forEach({
            $1.removeFromSuperlayer()
        })

        lineLayer.removeFromSuperlayer()
        lineLayer.bounds = CGRect.init(x: 0, y: 0, width: windowLayerWidth, height: windowLayerHeight)

        let offset = lineWidth / 2

        // left top
        drawLines(startPoint: CGPoint(x: 0, y: offset), endPoint: CGPoint(x: lineLength, y: offset), lineColor: cornerColor)
        drawLines(startPoint: CGPoint(x: offset, y: 0), endPoint: CGPoint(x: offset, y: lineLength), lineColor: cornerColor)

        // right top
        drawLines(startPoint: CGPoint(x: windowLayerWidth, y: offset), endPoint: CGPoint(x: windowLayerWidth - lineLength, y: offset), lineColor: cornerColor)
        drawLines(startPoint: CGPoint(x: windowLayerWidth - offset, y: 0), endPoint: CGPoint(x: windowLayerWidth - offset, y: lineLength), lineColor: cornerColor)

        // left bottom
        drawLines(startPoint: CGPoint(x: 0, y: windowLayerHeight - offset), endPoint: CGPoint(x: lineLength, y: windowLayerHeight - offset), lineColor: cornerColor)
        drawLines(startPoint: CGPoint(x: offset, y: windowLayerHeight), endPoint: CGPoint(x: offset, y: windowLayerHeight - lineLength), lineColor: cornerColor)

        // right bottom
        drawLines(startPoint: CGPoint(x: windowLayerWidth, y: windowLayerHeight - offset), endPoint: CGPoint(x: windowLayerWidth - lineLength, y: windowLayerHeight - offset), lineColor: cornerColor)
        drawLines(startPoint: CGPoint(x: windowLayerWidth - offset, y: windowLayerHeight), endPoint: CGPoint(x: windowLayerWidth - offset, y: windowLayerHeight - lineLength), lineColor: cornerColor)

        let borderLayer = CAShapeLayer.init()
        borderLayer.borderWidth = borderWidth
        borderLayer.frame = interestRect
        borderLayer.borderColor = borderColor.cgColor
        self.layer.addSublayer(borderLayer)
        self.layer.addSublayer(lineLayer)
    }

    private func drawLines(startPoint: CGPoint, endPoint: CGPoint, lineColor: UIColor) {
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        let line = CAShapeLayer()
        line.lineWidth = lineWidth
        line.strokeColor = lineColor.cgColor
        line.path = linePath.cgPath
        lineLayer.addSublayer(line)
    }

    public func onStartScan() {
        addScannerLineAnimation()
    }

    public func onStopScan() {
        pauseScannerLineAnimation()
    }

    public func onTorchOn() {

    }

    public func onTorchOff() {

    }

    public func onDidBecomeActive() {

    }

    public func onWillResignActive() {

    }

    public func onPermissionsStatusChange() {

    }

    public func onScanTimeout() {

    }
}
