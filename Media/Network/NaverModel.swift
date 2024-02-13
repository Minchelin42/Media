//
//  NaverModel.swift
//  Media
//
//  Created by 민지은 on 2024/02/13.
//

import Foundation


struct NaverModel: Decodable {
    let total: Int
    let display: Int
    var items: [Item]
}

struct Item: Decodable {
    let link: String
}
