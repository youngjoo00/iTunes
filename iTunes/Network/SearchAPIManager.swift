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

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "잘못된 URL 입니다."
        case .unknownResponse:
            return "알 수 없는 응답입니다."
        case .statusError:
            return "상태 에러가 발생했습니다."
        case .decodingFali:
            return "디코딩에 실패했습니다."
        case .noData:
            return "데이터가 없습니다."
        }
    }
}

final class SearchAPIManager {
    
    static let shared = SearchAPIManager()
    private init() {}
    
    // MARK: - AF.ObservableResult
//    func callRequest<T: Decodable>(type: T.Type, api: SearchAPI) -> Observable<Result<T, APIError>> {
//        
//        return Observable.create { observer in
//            AF.request(api.endPoint,
//                       parameters: api.parameter,
//                       encoding: URLEncoding(destination: .queryString))
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: type) { response in
//                switch response.result {
//                case .success(let value):
//                    observer.onNext(.success(value))
//                    observer.onCompleted()
//                case .failure(let error):
//                    observer.onNext(.failure(.invalidURL))
//                    observer.onCompleted()
//                }
//            }
//            
//            return Disposables.create()
//        }
//    }
    
    // MARK: - AF.SingleResult
//    func callRequest<T: Decodable>(type: T.Type, api: SearchAPI) -> Single<Result<T, APIError>> {
//        
//        return Single.create { single in
//            AF.request(api.endPoint,
//                       parameters: api.parameter,
//                       encoding: URLEncoding(destination: .queryString))
//            .responseDecodable(of: type) { response in
//                switch response.result {
//                case .success(let data): 
//                    single(.success(.success(data)))
//                case .failure(let fail):
//                    single(.success(.failure(.invalidURL)))
//                }
//            }
//            
//            return Disposables.create()
//        }
//    }
    
    // MARK: - URLSession.ObservableResult
//    func fetchAppData(api: SearchAPI) -> Observable<Result<App, APIError>> {
//        
//        return Observable<Result<App, APIError>>.create { observer in
//            
//            guard var component = URLComponents(url: api.endPoint, resolvingAgainstBaseURL: false) else {
//                print("컴포넌트 생성 실패")
//                return Disposables.create()
//            }
//            
//            // 여기서 자동으로 인코딩을 해준다!!
//            component.queryItems = api.parameter.map { URLQueryItem(name: $0.key, value: $0.value) }
//            
//            guard let componentURL = component.url else {
//                print("컴포넌트 URL 생성 실패")
//                return Disposables.create()
//            }
//            
//            var url = URLRequest(url: componentURL)
//            url.setValue("XYZ", forHTTPHeaderField: "User-Agent")
//            
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                
//                print("DataTask Succeed")
//                
//                if let _ = error {
//                    print("Error")
//                    return observer.onNext(.failure(.invalidURL))
//                }
//                
//                guard let response = response as? HTTPURLResponse,
//                      (200...299).contains(response.statusCode) else {
//                    print("Response Error")
//                    return observer.onNext(.failure(.statusError))
//                }
//                
//                if let data = data {
//                    do {
//                        let appData = try JSONDecoder().decode(App.self, from: data)
//                        observer.onNext(.success(appData))
//                    } catch {
//                        print("통신은 했는데 디코딩 실패: ", error)
//                        observer.onNext(.failure(.decodingFali))
//                    }
//                } else {
//                    print("통신은 했는데 데이터가 없음")
//                    observer.onNext(.failure(.noData))
//                }
//                
//                observer.onCompleted()
//            }.resume()
//            return Disposables.create()
//        }.debug()
//    }
    
    // MARK: - URLSession.SingleResult
    func fetchAppData(api: SearchAPI) -> Single<Result<App, APIError>> {
        
        return Single<Result<App, APIError>>.create { single in
            
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
                    return single(.success(.failure(.invalidURL)))
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Response Error")
                    return single(.success(.failure(.statusError)))
                }
                
                if let data = data {
                    do {
                        let appData = try JSONDecoder().decode(App.self, from: data)
                        single(.success(.success(appData)))
                    } catch {
                        print("통신은 했는데 디코딩 실패: ", error)
                        single(.success(.failure(.decodingFali)))
                    }
                } else {
                    print("통신은 했는데 데이터가 없음")
                    single(.success(.failure(.noData)))
                }
            }.resume()
            return Disposables.create()
        }.debug()
    }
}
