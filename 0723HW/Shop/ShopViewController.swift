//
//  ShopViewController.swift
//  0723HW
//
//  Created by Jimin on 7/26/25.
//

import UIKit

class ShopViewController: UIViewController {

    private lazy var searchBar = {
        let searchbar = UISearchBar()
        searchbar.delegate = self
        searchbar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchbar.searchTextField.textColor = .white
        searchbar.searchTextField.backgroundColor = .darkGray
        searchbar.searchBarStyle = .minimal
        return searchbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }

}

extension ShopViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        let vc = ResultViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
    }
}

extension ShopViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchBar)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
}
