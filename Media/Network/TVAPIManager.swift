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
    
    func getTVAPI(APItype: String, completionHandler: @escaping((TVModel) -> Void)) {
        print(#function)
        let url = "https://api.themoviedb.org/3/\(APItype)?language=ko-KR"
        let header: HTTPHeaders = ["Authorization": APIKey.tmDB]
        
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
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
