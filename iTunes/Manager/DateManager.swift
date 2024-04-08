//
//  DateManager.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import Foundation
import Then

final class DateManager {
    
    static let shared = DateManager()
    
    private init() { }
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    func formatDateString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
}
