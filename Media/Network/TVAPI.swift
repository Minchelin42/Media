//
//  TVAPI.swift
//  Media
//
//  Created by 민지은 on 2024/02/01.
//

import Foundation
import Alamofire

enum TVAPI {
    
    case trending
    case top_rated
    case popular
    case cast(code: Int)
    case detail(code: Int)
    case recommand(code: Int)
    case search(query: String)
    case episodeDetail(code: Int, season: Int)

    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }

    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/tv/day")!
        case .top_rated:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .cast(let code):
            return URL(string: baseURL + "tv/\(code)/aggregate_credits")!
        case .detail(let code):
            return URL(string: baseURL + "tv/\(code)")!
        case .recommand(let code):
            return URL(string: baseURL + "tv/\(code)/recommendations")!
        case .search:
            return URL(string: baseURL + "search/tv")!
        case .episodeDetail(let code, let season):
            return URL(string: baseURL + "tv/\(code)/season/\(season)")!
        }
    }
    
    var header: HTTPHeaders {
        return  ["Authorization": APIKey.tmDB]
    }
    
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            return ["language" : "ko-KR"]
        case .top_rated:
            return ["language" : "ko-KR"]
        case .popular:
            return ["language" : "ko-KR"]
        case .cast:
            return ["" : ""]
        case .detail:
            return ["language" : "ko-KR"]
        case .recommand:
            return ["language" : "ko-KR"]
        case .search(let query):
            return ["query" : query, "language" : "ko-KR"]
        case .episodeDetail:
            return ["language" : "ko-KR"]
        }
    }
    
    
    
    
}
