//
//  ShopRouter.swift
//  0723HW
//
//  Created by Jimin on 8/14/25.
//

import Foundation
import Alamofire

enum ShopRouter {
    
    case shop(query: String, currentPage: Int)
    
    var baseURL: String {
        return "https://openapi.naver.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .shop(let query, let currentPage):
            return URL(string: baseURL + "v1/search/shop.json?query=\(query)&display=30&start=\(currentPage * 30 + 1)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["X-Naver-Client-Id": "PfZWdQl4Ow2hZsu3tGQI", "X-Naver-Client-Secret": "4GzFGmEtFr"]
    }
}
