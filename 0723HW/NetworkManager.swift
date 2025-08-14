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
    
    func callRequest<T: Decodable>(api: ShopRouter, type: T.Type, success: @escaping (T) -> Void, fail: @escaping () -> Void) {
        AF.request(api.endpoint, headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    fail()
                }
            }
    }
}
