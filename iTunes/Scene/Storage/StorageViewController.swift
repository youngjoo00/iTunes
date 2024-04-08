//
//  StorageViewController.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class StorageViewController: BaseViewController {
    
    private let mainView = StorageView()
    private let viewModel = StorageViewModel()
    
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
        navigationItem.title = "보관함"
        navigationController?.navigationBar.prefersLargeTitles = true // Large title
    }
    
    private func bind() {
        
        let input = StorageViewModel.Input(searchText: mainView.searchController.searchBar.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.appList
            .bind(to: mainView.storageTableView.rx.items(cellIdentifier: StorageTableViewCell.identifier,
                                                      cellType: StorageTableViewCell.self)) { row, item, cell in
                cell.updateCell(item)
            }
            .disposed(by: disposeBag)
    }
}
