//
//  SearchViewModel.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: CommonViewModel {
    
    var disposeBag = DisposeBag()
    
    let recentCellDeleteButtonTap = PublishRelay<Int>()
    
    struct Input {
        let searchText: ControlProperty<String?>
        let searchButtonTap: ControlEvent<Void>
        let searchTextDidBeginEditing: ControlEvent<Void>
        let searchTextDidEndEditing: ControlEvent<Void>
        let recentCellTap: ControlEvent<String>
    }
    
    struct Output {
        let appList: PublishRelay<[AppResult]>
        let recentList: BehaviorRelay<[String]>
        let searchEditingState: BehaviorRelay<Bool>
        let searchText: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        
        let appList = PublishRelay<[AppResult]>()
        let recentList = BehaviorRelay(value: UserDefaultsManager.shared.getRecent())
        let searchEditingState = BehaviorRelay(value: true)
        let searchText = PublishRelay<String>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText.orEmpty)
            .do { UserDefaultsManager.shared.saveRecent($0) }
            .flatMap { SearchAPIManager.shared.fetchAppData(api: .search(query: $0)) }
            .subscribe(with: self) { owner, value in
                appList.accept(value.results)
                let current = UserDefaultsManager.shared.getRecent()
                recentList.accept(current)
            }
            .disposed(by: disposeBag)

        input.recentCellTap
            .do(onNext: { value in
                UserDefaultsManager.shared.saveRecent(value)
                searchText.accept(value)
                let current = UserDefaultsManager.shared.getRecent()
                recentList.accept(current)
                searchEditingState.accept(true)
            })
            .flatMapLatest { SearchAPIManager.shared.fetchAppData(api: .search(query: $0)) }
            .subscribe(with: self) { owner, value in
                appList.accept(value.results)
            }
            .disposed(by: disposeBag)
        
        input.searchTextDidBeginEditing
            .subscribe(with: self, onNext: { owner, _ in
                searchEditingState.accept(false)
            })
            .disposed(by: disposeBag)
        
        input.searchTextDidEndEditing
            .subscribe(with: self, onNext: { owner, _ in
                searchEditingState.accept(true)
            })
            .disposed(by: disposeBag)
        
        recentCellDeleteButtonTap
            .subscribe(with: self) { owner, value in
                UserDefaultsManager.shared.deleteRecent(value)
                let current = UserDefaultsManager.shared.getRecent()
                recentList.accept(current)
            }
            .disposed(by: disposeBag)
        
        return Output(appList: appList,
                      recentList: recentList,
                      searchEditingState: searchEditingState,
                      searchText: searchText)
    }
}
