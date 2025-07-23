//
//  MovieTableViewCell.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    private let inputFormat = DateFormatter()
    private let outputFormat = DateFormatter()
    
    private let boxView = UIView()
    private let numLabel = UILabel()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(row: Movie, index: Int) {
        numLabel.text = "\(index + 1)"
        titleLabel.text = row.title
        
        inputFormat.dateFormat = "yyyyMMdd"
        outputFormat.dateFormat = "yyyy-MM-dd"
        if let date = inputFormat.date(from: row.releaseDate) {
            dateLabel.text = outputFormat.string(from: date)
        }
    }
}

extension MovieTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(boxView)
        contentView.addSubview(numLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        boxView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(45)
            make.height.equalTo(5)
        }
        
        numLabel.snp.makeConstraints { make in
            make.edges.equalTo(boxView.snp.edges).inset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(boxView.snp.trailing).offset(25)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(100)
        }
    }
    
    func configureView() {
        boxView.backgroundColor = .white
        
        numLabel.text = "1"
        numLabel.textColor = .black
        numLabel.font = .boldSystemFont(ofSize: 20)
        numLabel.textAlignment = .center
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textAlignment = .right
    }
}
