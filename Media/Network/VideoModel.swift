//
//  VideoModel.swift
//  Media
//
//  Created by 민지은 on 2024/02/12.
//

import Foundation

struct VideoModel: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
}

