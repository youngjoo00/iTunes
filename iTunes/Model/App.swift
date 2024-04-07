//
//  Software.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import Foundation

struct App: Codable {
    let resultCount: Int // 결과 개수
    let results: [AppResult] // 앱 결과 배열
}

struct AppResult: Codable {
    let screenshotUrls: [String] // 스크린샷 URL 배열
    let artworkUrl512: String // 아트워크 512x512 URL
    let releaseNotes: String? // 릴리스 노트
    let genres: [String] // 장르 배열
    let price: Double? // 가격
    let description: String // 설명
    let version: String // 버전
    let userRatingCount: Int // 사용자 평가 수
    let averageUserRating: Double // 평균 사용자 평점
    let trackContentRating: String // 트랙 콘텐츠 등급
    let trackName: String // 트랙 이름
    let sellerName: String // 판매자 이름
}

//resultCount: Int
//results: [
//    screenshotUrls
//    artworkUrl512
//    formattedPrice
//    trackContentRating
//    releaseNotes
//    artistName
//    genres
//    price
//    description
//    releaseDate
//    trackName
//    sellerName
//    version
//]
