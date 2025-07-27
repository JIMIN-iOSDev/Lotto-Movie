//
//  ResultViewController.swift
//  0723HW
//
//  Created by Jimin on 7/26/25.
//

import UIKit
import SnapKit
import Alamofire

class ResultViewController: UIViewController {

    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (20 * 2) - 20
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/2 + 90)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
        cv.backgroundColor = .clear
        return cv
    }()
    private let totalLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 57/255, green: 255/255, blue: 20/255, alpha: 1.0)
        return label
    }()
    
    var list: Shop = Shop(total: 0, items: [])
    var searchText: String?
    private let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func callRequest(query: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=100"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "PfZWdQl4Ow2hZsu3tGQI",
            "X-Naver-Client-Secret": "4GzFGmEtFr"
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    self.list = value
                    self.collectionView.reloadData()
                    self.totalLabel.text = "\(self.numberFormatter.string(for: value.total) ?? "0") 개의 검색 결과"
                case .failure(let error):
                    print("fail", error)
                }
        }
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as! ShopCollectionViewCell
        cell.configureData(row: list.items[indexPath.item])
        
        DispatchQueue.main.async {
            cell.likeButton.layer.cornerRadius = cell.likeButton.frame.width / 2
        }
        cell.likeButton.clipsToBounds = true
        
        return cell
    }
}

extension ResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        title = searchText
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
