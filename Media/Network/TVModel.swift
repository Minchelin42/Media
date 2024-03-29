//
//  TrendModel.swift
//  Media
//
//  Created by 민지은 on 2024/01/30.
//

import Foundation

struct TVModel: Decodable {
    let results: [TV]
}

struct TV: Decodable {
    let name: String
    let poster_path: String?
    let id: Int
}
