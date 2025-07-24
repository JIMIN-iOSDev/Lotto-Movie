//
//  RankLabel.swift
//  0723HW
//
//  Created by Jimin on 7/24/25.
//

import UIKit

class RankLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(size: CGFloat, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: size)
        self.textAlignment = alignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
