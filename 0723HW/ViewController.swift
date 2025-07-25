//
//  ViewController.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let lottoButton = {
        let button = UIButton()
        button.setTitle("Lotto", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    private let movieButton = {
        let button = UIButton()
        button.setTitle("Movie", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    private let shopButton = {
        let button = UIButton()
        button.setTitle("Shop", for: .normal)
        button.backgroundColor = .purple
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        lottoButton.addTarget(self, action: #selector(lottoButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
    }
    
    @objc private func lottoButtonTapped() {
        let vc = LottoViewController()
        present(vc, animated: true)
    }
    
    @objc private func movieButtonTapped() {
        let vc = MovieViewController()
        present(vc, animated: true)
    }
    
    @objc private func shopButtonTapped() {
        let vc = ShopViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
    }
}

extension ViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(lottoButton)
        view.addSubview(movieButton)
        view.addSubview(shopButton)
    }
    
    func configureLayout() {
        lottoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        movieButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lottoButton.snp.bottom).offset(40)
            make.size.equalTo(200)
        }
        shopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieButton.snp.bottom).offset(40)
            make.size.equalTo(200)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}
