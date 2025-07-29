//
//  ShopViewController.swift
//  0723HW
//
//  Created by Jimin on 7/26/25.
//

import UIKit

class ShopViewController: UIViewController {

    lazy var searchBar = {
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
        guard let text = searchBar.text, text.count > 1 else {
            print("글자 수가 2미만 입니다")
            return
        }
        let vc = ResultViewController()
        vc.searchText = text
        vc.list.removeAll()
        vc.currentPage = 1
        vc.callRequest(query: text)
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        searchBar.text = ""
        view.endEditing(true)
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
        title = "영캠러의 쇼핑쇼핑"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
