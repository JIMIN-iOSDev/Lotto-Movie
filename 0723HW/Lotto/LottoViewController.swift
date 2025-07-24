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
    
    private let num1 = UILabel()
    private let num2 = UILabel()
    private let num3 = UILabel()
    private let num4 = UILabel()
    private let num5 = UILabel()
    private let num6 = UILabel()
    private let num7 = UILabel()
    private let num8 = UILabel()
//    private let back1 = UIImageView()
    private let lottoNumber = UIStackView()
    
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
        view.addSubview(lottoNumber)
        
        lottoNumber.addArrangedSubview(num1)
        lottoNumber.addArrangedSubview(num2)
        lottoNumber.addArrangedSubview(num3)
        lottoNumber.addArrangedSubview(num4)
        lottoNumber.addArrangedSubview(num5)
        lottoNumber.addArrangedSubview(num6)
        lottoNumber.addArrangedSubview(num7)
        lottoNumber.addArrangedSubview(num8)
//        lottoNumber.addArrangedSubview(back1)
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
        
        lottoNumber.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.size.equalTo((UIScreen.main.bounds.width - 40) / 8)
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
        
        lottoNumber.axis = .horizontal
        lottoNumber.distribution = .fillEqually
        lottoNumber.spacing = 4
        lottoNumber.backgroundColor = .orange
        
        num1.text = "1"
        num1.textAlignment = .center
        num2.text = "1"
        num3.text = "1"
        num4.text = "1"
        num5.text = "1"
        num6.text = "1"
        num7.text = "1"
        num8.text = "1"
        
    }
}
