//
//  UserDefalutsManager.swift
//  iTunes
//
//  Created by youngjoo on 4/7/24.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    let userDefaluts = UserDefaults.standard
    let recentKey = "recentKey"
    
    func saveRecent(_ text: String) {
        var recentList = getRecent()
        
        // 중복된 검색어 제거
        if let index = recentList.firstIndex(of: text) {
            recentList.remove(at: index)
        }

        recentList.insert(text, at: 0)
        userDefaluts.setValue(recentList, forKey: recentKey)
    }
    
    func getRecent() -> [String] {
        return userDefaluts.stringArray(forKey: recentKey) ?? []
    }
    
    func deleteRecent(_ index: Int) {
        var recentList = getRecent()
        recentList.remove(at: index)
        userDefaluts.setValue(recentList, forKey: recentKey)
    }
}
