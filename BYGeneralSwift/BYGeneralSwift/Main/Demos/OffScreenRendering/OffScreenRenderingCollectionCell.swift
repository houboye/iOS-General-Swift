//
//  OffScreenRenderingCollectionCellCollectionViewCell.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/2/7.
//

import UIKit

class OffScreenRenderingCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "OffScreenRenderingCollectionCell"
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(image: UIImage?) {
        imageView.image = image
    }
}
