//
//  EpisodeDetailModel.swift
//  Media
//
//  Created by 민지은 on 2024/02/04.
//

import Foundation

struct EpisodeDetailModel: Decodable {
    let name: String
    let overview: String
    let episodes: [Episode]
    let poster_path: String?
}

struct Episode: Decodable {
    let episode_number: Int
    let name: String
    let overview: String
    let runtime: Int
    let still_path: String?
}
