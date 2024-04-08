//
//  StorageView.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import UIKit
import Then

final class StorageView: BaseView {
    
    let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "보관한 앱을 검색해보세요."
    }
    
    let storageTableView = CustomTableView().then {
        $0.register(StorageTableViewCell.self, forCellReuseIdentifier: StorageTableViewCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 44
    }
    
    override func configureHierarchy() {
        [
            storageTableView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        
        storageTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
}
