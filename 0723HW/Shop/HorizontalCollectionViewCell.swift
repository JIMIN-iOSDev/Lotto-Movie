//
//  HorizontalCollectionViewCell.swift
//  0723HW
//
//  Created by 서지민 on 7/29/25.
//

import UIKit
import SnapKit
import Kingfisher

class HorizontalCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalCollectionViewCell"
    
    private let image = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(row: ShopList) {
        let url = URL(string: row.image)
        image.kf.setImage(with: url)
    }
}

extension HorizontalCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(image)
    }
    
    func configureLayout() {
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
