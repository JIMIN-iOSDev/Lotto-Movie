//
//  ViewController.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let lottoButton = UIButton()
    private let movieButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        lottoButton.addTarget(self, action: #selector(lottoButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    }
    
    @objc private func lottoButtonTapped() {
        let vc = LottoViewController()
        present(vc, animated: true)
    }
    
    @objc private func movieButtonTapped() {
        let vc = MovieViewController()
        present(vc, animated: true)
    }
}

extension ViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(lottoButton)
        view.addSubview(movieButton)
    }
    
    func configureLayout() {
        lottoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.size.equalTo(200)
        }
        movieButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lottoButton.snp.bottom).offset(60)
            make.size.equalTo(200)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        lottoButton.setTitle("Lotto", for: .normal)
        lottoButton.backgroundColor = .green
        movieButton.setTitle("Movie", for: .normal)
        movieButton.backgroundColor = .orange
    }
}
