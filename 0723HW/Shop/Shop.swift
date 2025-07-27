//
//  Shop.swift
//  0723HW
//
//  Created by Jimin on 7/26/25.
//

import Foundation

struct Shop: Decodable {
    let total: Int
    let items: [ShopList]
}

struct ShopList: Decodable {
    let title: String
    let image: String
    let mallName: String
    let lprice: String
}
