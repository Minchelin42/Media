//
//  TVSessionManager.swift
//  Media
//
//  Created by 민지은 on 2024/02/06.
//

import Foundation

enum TVAPIError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TVSessionManager {
    static let shared = TVSessionManager()

    func fetchTV(api: TVAPI, completionHandler: @escaping (TVModel?, TVAPIError?) -> Void) {
        var url = URLRequest(url: api.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmDB, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("통신을 성공했지만, 데이터가 안옴")
                    completionHandler(nil, .noData)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    print("통신은 성공했지만, 응답값이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
              
                guard response.statusCode == 200 else {
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try
                    JSONDecoder().decode(TVModel.self, from: data)
                    dump(result)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
            
            
        }.resume()
    }
    
}
