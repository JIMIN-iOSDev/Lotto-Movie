//
//  LottoNumber.swift
//  0723HW
//
//  Created by 서지민 on 7/24/25.
//

import UIKit

class LottoNumber: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "1"
        self.textColor = .white
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
