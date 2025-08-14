//
//  ShopViewController.swift
//  0723HW
//
//  Created by Jimin on 7/26/25.
//

import UIKit

class ShopViewController: UIViewController {
    
    private let viewModel = ShopViewModel()

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
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.navigation = { resultVC in
            self.navigateToResult(VC: resultVC)
        }
        
        viewModel.clearSearchText = {
            self.searchBar.text = ""
        }
        
        viewModel.endEditing = {
            self.view.endEditing(true)
        }
    }
    
    private func navigateToResult(VC: ResultViewController) {
        navigationController?.pushViewController(VC, animated: true)    // 바로 VC 넣으면 데이터 설정한 게 연동이 안되고 새로운 빈 VC를 생성하는 거임
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
    }
}


extension ShopViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchButtonTapped(text: searchBar.text)
        let vc = ResultViewController()
        vc.viewModel.output.scrollToTop.value = ()
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
