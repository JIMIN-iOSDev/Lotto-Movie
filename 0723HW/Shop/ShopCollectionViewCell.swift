//
//  ShopCollectionViewCell.swift
//  0723HW
//
//  Created by Jimin on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher

class ShopCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShopCollectionViewCell"
    
    private let image = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    private let brand = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    private let title = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let price = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    private let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    let likeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        likeButton.layer.cornerRadius = likeButton.frame.width / 2
//        likeButton.clipsToBounds = true
//    }
    
    func configureData(row: ShopList) {
        let url = URL(string: row.image)
        image.kf.setImage(with: url)
        brand.text = row.mallName
        title.text = row.title.htmlEscaped
        price.text = numberFormatter.string(for: Int(row.lprice))
    }
    
    override func draw(_ rect: CGRect) {
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
    }
}

extension ShopCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(image)
        contentView.addSubview(brand)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(likeButton)
    }
    
    func configureLayout() {
        image.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(image.snp.width)
        }
        
        brand.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(4)
            make.leading.equalTo(image.snp.leading).offset(8)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(brand.snp.bottom).offset(4)
            make.leading.equalTo(brand.snp.leading)
            make.trailing.equalToSuperview()
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.leading.equalTo(brand.snp.leading)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(image).inset(8)
            make.size.equalTo(30)
        }
    }
    
    func configureView() {
    }
}

// HTML 태그 제거 - 블로그에서 복붙
extension String {
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData, options: options, documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}
