//
//  HomeViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit
import LTMorphingLabel
import BaseControllers

class HomeViewController: BaseViewController {
    private let animationLabel = LTMorphingLabel()
    private let label = LTMorphingLabel()
    private let changeButton = UIButton()
    private var effectRawvalue = 0 // 0~6
    private let textArray = [
        "What is design?",
        "Design", "Design is not just", "what it looks like", "and feels like.",
        "Design", "is how it works.", "- Steve Jobs",
        "Older people", "sit down and ask,", "'What is it?'",
        "but the boy asks,", "'What can I do with it?'.", "- Steve Jobs",
        "One more thing...", "Swift", "Objective-C", "iPhone", "iPad", "Mac Mini",
        "MacBook Pro🔥", "Mac Pro⚡️",
        "爱老婆",
        "नमस्ते दुनिया",
        "हिन्दी भाषा",
        "$68.98",
        "$68.99",
        "$69.00",
        "$69.01"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        animationLabel.text = ""
        animationLabel.textColor = UIColor.white
        animationLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        animationLabel.numberOfLines = 0
        animationLabel.textAlignment = .center
        view.addSubview(animationLabel)
        animationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(90)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        label.text = "Hello Swift!"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.addSubview(changeButton)
        changeButton.layer.cornerRadius = 30
        changeButton.setTitleColor(UIColor.white, for: .normal)
        changeButton.setTitle("Play!", for: .normal)
        changeButton.layer.borderColor = UIColor.white.cgColor
        changeButton.layer.borderWidth = 2
        changeButton.addTarget(self, action: #selector(playAnimation), for: .touchUpInside)
        changeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 60))
        }
    }

    @objc private func playAnimation() {
        if let effect = LTMorphingEffect(rawValue: effectRawvalue) {
            label.morphingEffect = effect
            label.text = "Hello Swift! + \(effectRawvalue)"
            let index = Int.random(in: 0..<textArray.count)
            animationLabel.morphingEffect = effect
            animationLabel.text = textArray[index]
            if effectRawvalue < 6 {
                effectRawvalue += 1
            } else {
                effectRawvalue = 0
            }
        }
    }
}
