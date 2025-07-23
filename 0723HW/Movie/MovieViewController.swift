//
//  MovieViewController.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {

    private let searchTextField = UITextField()
    private let searchButton = UIButton()
    private let tableView = UITableView()
    private var movie = MovieInfo.movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        movie.shuffle()
        tableView.reloadData()
    }
}

extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movie.shuffle()
        tableView.reloadData()
        view.endEditing(true)
        return true
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = .clear
        cell.configureData(row: movie[indexPath.row], index: indexPath.row)
        return cell
    }
}

extension MovieViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(15)
        }
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(searchTextField.snp.bottom)
            make.trailing.equalToSuperview().offset(-15)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        searchTextField.font = .systemFont(ofSize: 17)
        searchTextField.textColor = .white
        searchTextField.delegate = self
        
//        let border = CALayer()
//        border.borderWidth = 1.0
//        border.borderColor = UIColor.white.cgColor
//        border.frame = CGRect(x: 0, y: searchTextField.frame.height - 1, width: searchTextField.frame.width, height: 1)
//        searchTextField.borderStyle = .none
//        searchTextField.layer.addSublayer(border)
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        searchButton.backgroundColor = .white
        
        tableView.backgroundColor = .black
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
}
