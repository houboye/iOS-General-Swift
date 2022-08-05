//
//  DemosTableViewCell.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/10.
//

import UIKit

class DemosTableViewCell: UITableViewCell {
    static let identifier = "DemosTableViewCell"

    private var titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }

    func setupItem(_ item: DemoItem) {
        titleLabel.text = item.title
    }
}
