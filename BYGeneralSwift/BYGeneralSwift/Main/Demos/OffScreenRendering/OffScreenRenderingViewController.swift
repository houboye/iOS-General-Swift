//
//  OffScreenRenderingViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/13.
//

import UIKit
import BaseControllers

class OffScreenRenderingViewController: BaseViewController {

    lazy var collectionView: UICollectionView = {
        let flowLyout = UICollectionViewFlowLayout()
        flowLyout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        flowLyout.scrollDirection = .vertical
        flowLyout.minimumInteritemSpacing = 10

        let targetCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLyout)
        targetCollectionView.delegate = self
        targetCollectionView.dataSource = self
        targetCollectionView.register(OffScreenRenderingCollectionCell.self, forCellWithReuseIdentifier: OffScreenRenderingCollectionCell.reuseIdentifier)

        return targetCollectionView
    }()

    lazy var dataArray: [UIImage?] = {
        return [UIImage(named: "image_1920x1200.jpeg"),
                UIImage(named: "ktm-1290-super-duke_921x518.jpeg"),
                UIImage(named: "KTM1290_1920x1080.jpeg")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Off-Screen Rendering"
        view.backgroundColor = UIColor.white

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension OffScreenRenderingViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffScreenRenderingCollectionCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? OffScreenRenderingCollectionCell {
            cell.setContent(image: dataArray[indexPath.row % 3])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
