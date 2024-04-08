//
//  StorageAppRepository.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import Foundation
import RealmSwift

final class AppInfoRepository {
    
    var realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    func createItem(_ item: AppInfo) throws {
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL!)
            }
        } catch {
            print("저장 실패")
            throw error
        }
    }
    
    func fetchItem() -> [AppInfo] {
        return Array(realm.objects(AppInfo.self))
    }
    
    func deleteItem(_ item: AppInfo) throws {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("삭제 실패")
            throw error
        }
    }
    
    func filterItem(_ text: String) -> [AppInfo] {
        return fetchItem().filter { $0.title.contains(text) }
    }
}
