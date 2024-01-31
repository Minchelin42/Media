//
//  CastModel.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import Foundation

struct CastModel: Decodable {
        let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let profile_path: String?
}
