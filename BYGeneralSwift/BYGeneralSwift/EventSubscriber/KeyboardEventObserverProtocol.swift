//
//  KeyboardEventObserverProtocol.swift
//  umma
//
//  Created by iMoe on 2019/12/24.
//  Copyright © 2019 com.advance. All rights reserved.
//

import UIKit

/// Check out `SubscriberProtocolSpec.md` for detail.
@objc protocol KeyboardEventSubscriberProtocolOBJC: AnyObject {
    func keyboardShowingEventNotificationReceived(_ notification: Notification)
    func keyboardHidingEventNotificationReceived(_ notification: Notification)
}

/// Alias of three vital animation parameters.
public struct KeyboardAnimationParameters {
    public var endFrame: CGRect
    public var curve: UIView.AnimationOptions
    public var duration: Double
}

/// Check out `SubscriberProtocolSpec.md` for detail.
protocol KeyboardEventSubscriberProtocol: KeyboardEventSubscriberProtocolOBJC {

    func beginObservingKeyboardEvents()

    /// Invoked when the keyboard is about to be shown.
    func onKeyboardShowingEventNotificationReceived(_ notification: Notification)
    /// Invoked when the keyboard is about to hide.
    func onKeyboardHidingEventNotificationReceived(_ notification: Notification)

    func respondToKeyboardEvent(
        showingInsteadOfHiding: Bool,
        with parameters: KeyboardAnimationParameters)
}

extension KeyboardEventSubscriberProtocol {
    func beginObservingKeyboardEvents() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShowingEventNotificationReceived(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHidingEventNotificationReceived(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    func onKeyboardShowingEventNotificationReceived(_ notification: Notification) {
        guard let parameters = keyboardAnimationParamters(of: notification) else { return }
        respondToKeyboardEvent(showingInsteadOfHiding: true, with: parameters)
    }

    func onKeyboardHidingEventNotificationReceived(_ notification: Notification) {
        guard let parameters = keyboardAnimationParamters(of: notification) else { return }
        respondToKeyboardEvent(showingInsteadOfHiding: false, with: parameters)
    }

    /// Extract animation parameters from the system notification.
    func keyboardAnimationParamters(
        of notification: Notification
    ) -> KeyboardAnimationParameters? {
        let keyboardAnimationEndFrameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardAnimationCurveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let keyboardAnimationDurationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        guard
            let userInfo = notification.userInfo,
            let endFrame = userInfo[keyboardAnimationEndFrameKey] as? CGRect,
            let curveRawValue = userInfo[keyboardAnimationCurveKey] as? NSNumber,
            let duration = userInfo[keyboardAnimationDurationKey] as? Double
        else {
            return nil
        }
        let curve = UIView.AnimationOptions(rawValue: curveRawValue.uintValue<<16)
        return KeyboardAnimationParameters(endFrame: endFrame,
                                           curve: curve,
                                           duration: duration)
    }
}
