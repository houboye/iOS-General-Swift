//
//  DemosViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit

class DemosViewController: BaseViewController {
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    private lazy var dataArray: [DemoItem] = {
        [
            DemoItem(title: "Off-screen rendering", demoType: .offScreenRendering)
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demos"
        view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(DemosTableViewCell.self, forCellReuseIdentifier: DemosTableViewCell.identifier)
    }
}

extension DemosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DemosTableViewCell.identifier, for: indexPath)
        
        if let cell = cell as? DemosTableViewCell {
            cell.setupItem(dataArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handledidSelectRow(dataArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
