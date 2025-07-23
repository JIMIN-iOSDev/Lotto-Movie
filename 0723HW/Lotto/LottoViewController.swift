//
//  LottoViewController.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {

    private let roundTextField = UITextField()
    private let infoLabel = UILabel()
    private let dateLabel = UILabel()
    private let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension LottoViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(roundTextField)
        view.addSubview(infoLabel)
        view.addSubview(dateLabel)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        roundTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(50)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(120)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(60)
            make.width.equalTo(170)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        roundTextField.borderStyle = .roundedRect
        roundTextField.layer.borderColor = UIColor.lightGray.cgColor
        roundTextField.layer.borderWidth = 1
        roundTextField.layer.cornerRadius = 5
        roundTextField.clipsToBounds = true
        roundTextField.backgroundColor = .white
        roundTextField.inputView = UIPickerView()
        
        infoLabel.text = "당첨번호 안내"
        infoLabel.textColor = .black
        infoLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        dateLabel.text = "8888-88-88 추첨"
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textAlignment = .right
        
        resultLabel.text = "1181회 당첨결과"
        resultLabel.textColor = .black
        resultLabel.font = .boldSystemFont(ofSize: 25)
        resultLabel.textAlignment = .center
    }
}
