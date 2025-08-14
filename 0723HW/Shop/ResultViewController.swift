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
    
    let viewModel = ResultViewModel()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        bindData()
    }
    
    private func bindData() {
        viewModel.output.totalText.bind { _ in
            self.totalLabel.text = self.viewModel.output.totalText.value
        }
        
        viewModel.output.verticalReload.bind { _ in
            self.verticalCollectionView.reloadData()
        }
    
        viewModel.output.horizontalReload.bind { _ in
            self.horizontalCollectionView.reloadData()
        }
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == verticalCollectionView {
            return viewModel.list.count
        } else {
            return viewModel.horizontalList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == verticalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as! ShopCollectionViewCell
            cell.configureData(row: viewModel.list[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
            cell.configure(row: viewModel.horizontalList[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(#function)
        if collectionView == verticalCollectionView {
            if indexPath.row == (viewModel.list.count - 3) && viewModel.isEnd == false {
                viewModel.currentPage += 1
                viewModel.input.indexpath.value = ()
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
        title = viewModel.input.text.value
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
