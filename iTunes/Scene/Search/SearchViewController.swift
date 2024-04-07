//
//  SearchViewController.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    private func configureNavigation() {
        navigationItem.searchController = mainView.searchController
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true // Large title
        //definesPresentationContext = true
    }
    
    private func bind() {
        
        let input = SearchViewModel.Input(searchText: mainView.searchController.searchBar.rx.text,
                                          searchButtonTap: mainView.searchController.searchBar.rx.searchButtonClicked,
                                          searchTextDidBeginEditing: mainView.searchController.searchBar.rx.textDidBeginEditing,
                                          searchTextDidEndEditing: mainView.searchController.searchBar.rx.textDidEndEditing,
                                          recentCellTap: mainView.recentTableView.rx.modelSelected(String.self))
        
        let output = viewModel.transform(input: input)
        
        output.appList
            .bind(to: mainView.searchTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier,
                                                  cellType: SearchTableViewCell.self)) { row, element, cell in
                cell.updateCell(element)
            }
            .disposed(by: disposeBag)
        
        output.recentList
            .bind(to: mainView.recentTableView.rx.items(cellIdentifier: RecentTableViewCell.identifier,
                                                             cellType: RecentTableViewCell.self)) { row, element, cell in
                cell.updateCell(element)
                
                // 탭하면 뷰모델에 row 값 넘겨서 삭제하고 다시 테이블뷰 갱신
                cell.deleteButton.rx.tap
                    .map { row }
                    .bind(with: self, onNext: { owner, value in
                        owner.viewModel.recentCellDeleteButtonTap.accept(value)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.searchEditingState
            .bind(to: mainView.recentTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.searchEditingState
            .map { !$0 }
            .bind(to: mainView.searchTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.searchText
            .bind(to: mainView.searchController.searchBar.rx.text)
            .disposed(by: disposeBag)
        
        Observable.zip(mainView.searchTableView.rx.itemSelected, mainView.searchTableView.rx.modelSelected(AppResult.self))
            .subscribe(with: self) { owner, value in
                let vc = DetailSearchViewController()
                vc.appInfo = value.1
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
    }
}
