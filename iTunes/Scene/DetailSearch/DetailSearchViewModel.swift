//
//  DetailSearchViewModel.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailSearchViewModel: CommonViewModel {
    
    var disposeBag: DisposeBag = .init()
    
    struct Input {
        let appInfo: AppResult
    }
    
    struct Output {
        let iconImageURL: Driver<URL?>
        let title: Driver<String>
        let description: Driver<String>
        let rating: Driver<String>
        let seller: Driver<String>
        let genre: Driver<String>
        let screenshot: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        let data = input.appInfo
        
        let iconImageURL = Driver.just(data.artworkUrl512)
            .map { URL(string: $0) }
        
        let title = Driver.just(data.trackName)
        let description = Driver.just(data.description)
        let rating = Driver.just(data.averageUserRating.singleDigitString)
        let seller = Driver.just(data.sellerName)
        let genre = Driver.just(data.genres[0])
        let screenshot = Driver.just(data.screenshotUrls)
        
        return Output(iconImageURL: iconImageURL,
                      title: title,
                      description: description,
                      rating: rating,
                      seller: seller,
                      genre: genre,
                      screenshot: screenshot)
    }
}
