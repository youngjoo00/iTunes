//
//  SearchAPIManager.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
    case decodingFali
    case noData
}

final class SearchAPIManager {
    
    static let shared = SearchAPIManager()
    private init() {}
    
    //    func callRequest<T: Decodable>(type: T.Type, api: SearchAPI) -> Observable<T> {
    //
    //        return Observable.create { observer in
    //            AF.request(api.endPoint,
    //                       parameters: api.parameter,
    //                       encoding: URLEncoding(destination: .queryString))
    //            .validate(statusCode: 200..<300)
    //            .responseDecodable(of: type) { response in
    //                switch response.result {
    //                case .success(let value):
    //                    observer.onNext(value)
    //                    observer.onCompleted()
    //                case .failure(let error):
    //                    observer.onError(error)
    //                }
    //            }
    //
    //            return Disposables.create()
    //        }
    //    }
    
    func fetchAppData(api: SearchAPI) -> Observable<App> {
        
        return Observable<App>.create { observer in
            
            guard var component = URLComponents(url: api.endPoint, resolvingAgainstBaseURL: false) else {
                print("컴포넌트 생성 실패")
                return Disposables.create()
            }
            
            // 여기서 자동으로 인코딩을 해준다!!
            component.queryItems = api.parameter.map { URLQueryItem(name: $0.key, value: $0.value) }
            
            guard let componentURL = component.url else {
                print("컴포넌트 URL 생성 실패")
                return Disposables.create()
            }
            
            var url = URLRequest(url: componentURL)
            url.setValue("XYZ", forHTTPHeaderField: "User-Agent")
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("DataTask Succeed")
                
                if let _ = error {
                    print("Error")
                    return observer.onError(APIError.unknownResponse)
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Response Error")
                    return observer.onError(APIError.statusError)
                }
                
                if let data = data {
                    do {
                        let appData = try JSONDecoder().decode(App.self, from: data)
                        observer.onNext(appData)
                        observer.onCompleted()
                    } catch {
                        print("통신은 했는데 디코딩 실패: ", error)
                        observer.onError(APIError.decodingFali)
                    }
                } else {
                    print("통신은 했는데 데이터가 없음")
                    observer.onError(APIError.noData)
                }
            }.resume()
            return Disposables.create()
        }.debug()
        
    }
}
