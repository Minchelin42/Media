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
    
    func APIcall<T: Decodable>(type: T.Type, api: TVAPI, completionHandler: @escaping((T?, AFError?) -> Void)) {
        print(#function)

        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                print("success", success)
                
                completionHandler(success, nil)
            case .failure(let failure):
                print("fail", failure)
                
                completionHandler(nil, failure)
            }
        }
    }
    
}
