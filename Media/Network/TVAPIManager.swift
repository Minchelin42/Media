//
//  TvAPIManager.swift
//  Media
//
//  Created by 민지은 on 2024/01/30.
//

import Foundation
import Alamofire

class TVAPIManager {
    static let shared = TVAPIManager()
    
    func getTVAPI(api: TVAPI, completionHandler: @escaping((TVModel) -> Void)) {
        print(#function)

        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                print("success", success)
                
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    func getDramaAPI(api: TVAPI, completionHandler: @escaping((DramaModel) -> Void)) {
        print(#function)
        
        AF.request(api.endPoint, 
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: DramaModel.self) { response in
            switch response.result {
            case .success(let success):
                print("success", success)
                
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    
    func getEpisodeDetailAPI(api: TVAPI, completionHandler: @escaping((EpisodeDetailModel) -> Void)) {
        print(#function)
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: EpisodeDetailModel.self) { response in
            switch response.result {
            case .success(let success):
                print("success", success)
                
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    func getCastAPI(api: TVAPI, completionHandler: @escaping((CastModel) -> Void)) {
        print(#function)
        
        AF.request(api.endPoint,
                   headers: api.header)
        .responseDecodable(of: CastModel.self) { response in
            switch response.result {
            case .success(let success):
                print("success", success)
                
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
}
