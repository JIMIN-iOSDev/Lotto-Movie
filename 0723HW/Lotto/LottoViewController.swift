//
//  LottoViewController.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {

    private let pickerView = UIPickerView()
    private lazy var roundTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor.systemGray5.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.backgroundColor = .white
        tf.font = .boldSystemFont(ofSize: 20)
        tf.textAlignment = .center
        tf.inputView = pickerView
        return tf
    }()
    private let infoLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    private let dateLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    private let lineView = {
        let line = UIView()
        line.backgroundColor = .systemGray6
        return line
    }()
    private let resultLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let num1 = UILabel()
    private let num2 = UILabel()
    private let num3 = UILabel()
    private let num4 = UILabel()
    private let num5 = UILabel()
    private let num6 = UILabel()
    private let num7 = UILabel()
    private let num8 = UILabel()
    private let lottoNumber = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        callRequest(drwNo: 1181)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    func callRequest(drwNo: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)"
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.roundTextField.text = "\(drwNo)"
                self.dateLabel.text = "\(value.drwNoDate) 추첨"
                self.resultLabel.text = "\(value.drwNo)회 당첨결과"
            case .failure(let error):
                print("fail", error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1181
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(1181 - row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callRequest(drwNo: 1181 - row)
    }
}

extension LottoViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(roundTextField)
        view.addSubview(infoLabel)
        view.addSubview(dateLabel)
        view.addSubview(lineView)
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
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(15)
            make.leading.equalTo(infoLabel.snp.leading)
            make.trailing.equalTo(dateLabel.snp.trailing)
            make.height.equalTo(2)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(40)
            make.width.equalTo(200)
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
