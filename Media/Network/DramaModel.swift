//
//  DramaModel.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import Foundation

struct DramaModel: Decodable {
    let name: String
    let seasons: [Season]
    let overview: String
    let poster_path: String
}

struct Season: Decodable {
    let name: String
    let overview: String?
    let poster_path: String?
    let id: Int
    let season_number: Int
}
