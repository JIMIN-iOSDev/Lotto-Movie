//
//  MovieViewController.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class MovieViewController: UIViewController {

    private let searchTextField = UITextField()
    private let textFieldUnderline = UIView()
    private let searchButton = UIButton()
    private let tableView = UITableView()
//    private var movie = MovieInfo.movies
    
    private let rankLabel = RankLabel(size: 20, alignment: .center)
    private let rankLabel2 = RankLabel(size: 20, alignment: .center)
    private let rankLabel3 = RankLabel(size: 20, alignment: .center)
    private let titleLabel = RankLabel(size: 17, alignment: .left)
    private let titleLabel2 = RankLabel(size: 17, alignment: .left)
    private let titleLabel3 = RankLabel(size: 17, alignment: .left)
    private let openDate = RankLabel(size: 13, alignment: .right)
    private let openDate2 = RankLabel(size: 13, alignment: .right)
    private let openDate3 = RankLabel(size: 13, alignment: .right)
    
    private var rankLabels: [UILabel] = []
    private var titleLabels: [UILabel] = []
    private var dateLabels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankLabels = [rankLabel, rankLabel2, rankLabel3]
        titleLabels = [titleLabel, titleLabel2, titleLabel3]
        dateLabels = [openDate, openDate2, openDate3]
        
        configureHierarchy()
        configureLayout()
        configureView()
        callRequest(text: "20250723")
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
//        movie.shuffle()
//        tableView.reloadData()
        callRequest(text: searchTextField.text ?? "0")
        searchTextField.text = ""
        view.endEditing(true)
    }
    
    func callRequest(text: String) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=eae59d71a034dc27fade2ddaca91fc45&targetDt=\(text)"
        
        AF.request(url, method: .get).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                let list = value.boxOfficeResult.dailyBoxOfficeList
                for i in 0..<3 {
                    self.rankLabels[i].text = list[i].rank
                    self.titleLabels[i].text = list[i].movieNm
                    self.dateLabels[i].text = list[i].openDt
                }
            case .failure(let error):
                print("fail", error)
            }
        }
    }
    
}

//extension MovieViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        movie.shuffle()
//        tableView.reloadData()
//        view.endEditing(true)
//        return true
//    }
//}

//extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
//        cell.backgroundColor = .clear
//        cell.configureData(row: movie[indexPath.row], index: indexPath.row)
//        return cell
//    }
//}

extension MovieViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchTextField)
        view.addSubview(textFieldUnderline)
        view.addSubview(searchButton)
//        view.addSubview(tableView)
        for i in 0..<3 {
            view.addSubview(rankLabels[i])
            view.addSubview(titleLabels[i])
            view.addSubview(dateLabels[i])
        }
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        textFieldUnderline.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(8)
            make.leading.equalTo(searchTextField.snp.leading)
            make.width.equalTo(searchTextField.snp.width)
            make.height.equalTo(2)
        }
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(textFieldUnderline.snp.bottom)
            make.trailing.equalToSuperview().offset(-15)
            make.leading.equalTo(searchTextField.snp.trailing).offset(16)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
//        tableView.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview()
//            make.top.equalTo(searchTextField.snp.bottom).offset(15)
//            make.bottom.equalToSuperview()
//        }
        
        rankLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(20)
        }
        
        rankLabel2.snp.makeConstraints { make in
            make.top.equalTo(rankLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(20)
        }
        
        rankLabel3.snp.makeConstraints { make in
            make.top.equalTo(rankLabel2.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel.snp.centerY)
            make.leading.equalTo(rankLabel.snp.trailing).offset(30)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel2.snp.centerY)
            make.leading.equalTo(rankLabel2.snp.trailing).offset(30)
        }
        
        titleLabel3.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel3.snp.centerY)
            make.leading.equalTo(rankLabel3.snp.trailing).offset(30)
        }
        
        openDate.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.width.equalTo(80)
        }
        
        openDate2.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel2.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(titleLabel2.snp.trailing).offset(4)
            make.width.equalTo(80)
        }
        
        openDate3.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel3.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(titleLabel3.snp.trailing).offset(4)
            make.width.equalTo(80)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        searchTextField.font = .systemFont(ofSize: 17)
        searchTextField.textColor = .white
        searchTextField.keyboardType = .numberPad
//        searchTextField.delegate = self
        
        textFieldUnderline.backgroundColor = .white
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        searchButton.backgroundColor = .white
        
//        tableView.backgroundColor = .black
//        tableView.rowHeight = 40
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        
    }
}
