//
//  StorageViewModel.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class StorageViewModel: CommonViewModel {
    
    var disposeBag = DisposeBag()
    var repository: AppInfoRepository?
    
    init() {
        do {
            repository = try AppInfoRepository()
        } catch {
            print("초기화 에러")
        }
    }
    
    let recentCellDeleteButtonTap = PublishRelay<Int>()
    
    struct Input {
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        let appList: BehaviorRelay<[AppInfo]>
    }
    
    func transform(input: Input) -> Output {
        
        let appList = BehaviorRelay(value: repository?.fetchItem() ?? [])
        
        input.searchText
            .orEmpty
            .subscribe(with: self) { owner, text in
                if text.isEmpty {
                    let list = owner.repository?.fetchItem() ?? []
                    appList.accept(list)
                } else {
                    let list = owner.repository?.filterItem(text) ?? []
                    appList.accept(list.isEmpty ? owner.repository?.fetchItem() ?? [] : list)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(appList: appList)
    }
}
