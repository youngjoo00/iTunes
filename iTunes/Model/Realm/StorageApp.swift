//
//  StorageApp.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import Foundation
import RealmSwift

class AppInfo: Object {
    @Persisted(primaryKey: true) var title: String
    @Persisted var iconImage: String
    @Persisted var regDate: Date
    
    convenience init(title: String, iconImage: String, regDate: Date) {
        self.init()
        self.title = title
        self.iconImage = iconImage
        self.regDate = regDate
    }
}
