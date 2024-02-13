//
//  NaverAPIManager.swift
//  Media
//
//  Created by 민지은 on 2024/02/13.
//

import Foundation
import Alamofire

class NaverAPIManager {
    static let shared = NaverAPIManager()
    
    func ImageAPI(search: String, start: Int, completionHandler: @escaping(NaverModel?, AFError?) -> Void) {
        print(#function)
        
        let url = "https://openapi.naver.com/v1/search/image?query=\(search)&display=30&start=\(start)"

        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverID,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable (of: NaverModel.self) { response in
            
            switch response.result {
            case .success(let success):
                dump(success.items)
                completionHandler(success, nil)
                
            case .failure(let failure):
                print("Error")
                completionHandler(nil, failure)
            }
            
        }
    }
        
}

    


