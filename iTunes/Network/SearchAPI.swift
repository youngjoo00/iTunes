//
//  SearchAPI.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import Foundation
import Alamofire

enum SearchAPI {
    case search(query: String)
    
    static let baseURL = "https://itunes.apple.com/"
    
    static let baseParameter: [String:String] = [
        "country": "KR",
        "media": "software",
        "entity": "software",
        "limit": "25"
    ]
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: SearchAPI.baseURL + "search")!
        }
    }
    
    var parameter: [String: String] {
        var parameters = SearchAPI.baseParameter
        switch self {
        case .search(let query):
            // Alamofire 에서는 이렇게 한글을 인코딩할 필요가 있지만, URLSession 에서는 urlComponents.queryItem 에 한글 파라미터를 추가할때는 자동으로 인코딩해준다!!
            // 아래의 코드까지 작성해버리면 인코딩을 두 번 하는 셈이라 한글 검색이 안되는 것이었다!
            //guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return parameters }
            parameters["term"] = query
            return parameters
        }
    }
    
}
