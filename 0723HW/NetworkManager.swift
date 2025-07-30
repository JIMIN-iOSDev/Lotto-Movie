//
//  NetworkManager.swift
//  0723HW
//
//  Created by 서지민 on 7/29/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest(query: String, currentPage: Int, success: @escaping (Shop) -> Void, fail: @escaping () -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&start=\(currentPage * 30 + 1)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "PfZWdQl4Ow2hZsu3tGQI",
            "X-Naver-Client-Secret": "4GzFGmEtFr"
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    fail()
                }
            }
    }
}
