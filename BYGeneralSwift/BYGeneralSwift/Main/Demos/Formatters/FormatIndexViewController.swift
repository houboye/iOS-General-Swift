//
//  FormatIndexViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/8/3.
//

import UIKit

class FormatIndexViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Formatters"
        view.backgroundColor = UIColor.white
        
        let buttonSize = CGSize(width: 180, height: 60)
        
        let dateFormatter = createButton("Date Format")
        view.addSubview(dateFormatter)
        dateFormatter.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(buttonSize)
        }
        
        let numberFormatter = createButton("Number Format")
        view.addSubview(numberFormatter)
        numberFormatter.snp.makeConstraints { make in
            make.centerX.equalTo(dateFormatter)
            make.top.equalTo(dateFormatter.snp.bottom).offset(50)
            make.size.equalTo(buttonSize)
        }
        
        let currencyFormatter = createButton("Currency Format")
        view.addSubview(currencyFormatter)
        currencyFormatter.snp.makeConstraints { make in
            make.centerX.equalTo(dateFormatter)
            make.bottom.equalTo(dateFormatter.snp.top).offset(-50)
            make.size.equalTo(buttonSize)
        }
        
        dateFormatter.addTarget(self, action: #selector(gotoDate), for: .touchUpInside)
        numberFormatter.addTarget(self, action: #selector(gotoNumber), for: .touchUpInside)
        currencyFormatter.addTarget(self, action: #selector(gotoCurrency), for: .touchUpInside)
    }
    
    @objc private func gotoDate() {
        navigationController?.push(viewController: DateFormatViewController())
    }
    
    @objc private func gotoNumber() {
        navigationController?.push(viewController: NumberFormatViewController())
    }
    
    @objc private func gotoCurrency() {
        navigationController?.push(viewController: CurrencyFormatViewController())
    }

    private func createButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }
}
