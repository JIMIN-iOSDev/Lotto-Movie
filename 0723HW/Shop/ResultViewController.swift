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

    private let totalLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 57/255, green: 255/255, blue: 20/255, alpha: 1.0)
        return label
    }()
    private lazy var verticalCollectionView = {
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
    private lazy var horizontalCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (10 * 2) - (10 * 3)
        
        layout.itemSize = CGSize(width: cellWidth/4, height: cellWidth/4)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        cv.backgroundColor = .clear
        return cv
    }()
    
    var list: [ShopList] = []
    var horizontalList: [ShopList] = []
    var searchText: String?
    var currentPage = 0
    var isEnd = false
    
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
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(currentPage * 30 + 1)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "PfZWdQl4Ow2hZsu3tGQI",
            "X-Naver-Client-Secret": "4GzFGmEtFr"
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    self.totalLabel.text = "\(self.numberFormatter.string(for: value.total) ?? "0") 개의 검색 결과"
                    
                    self.list.append(contentsOf: value.items)
                    self.verticalCollectionView.reloadData()
                    if self.currentPage == 0 {
                        self.verticalCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    if ((self.currentPage + 1) * 30) < value.total {
                        self.isEnd = false
                    } else {
                        self.isEnd = true
                    }
                    
                    self.horizontalList.append(contentsOf: value.items)
                    self.horizontalCollectionView.reloadData()
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == verticalCollectionView {
            return list.count
        } else {
            return horizontalList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == verticalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as! ShopCollectionViewCell
            cell.configureData(row: list[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
            cell.configure(row: horizontalList[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == verticalCollectionView {
            if indexPath.row == (list.count - 3) && isEnd == false {
                if let text = searchText {
                    currentPage += 1
                    callRequest(query: text)
                }
            }
        }
    }
}

extension ResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(verticalCollectionView)
        view.addSubview(horizontalCollectionView)
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        verticalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(550)
        }
        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(verticalCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        title = searchText
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
