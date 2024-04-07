//
//  SearchView.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import Then

final class SearchView: BaseView {
    
    let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "게임, 앱, 스토리 등"
    }
    
    let searchTableView = UITableView().then {
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 44
        $0.separatorStyle = .none
    }
    
    let recentTableView = UITableView().then {
        $0.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
        $0.estimatedRowHeight = 44
        $0.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        [
            searchTableView,
            recentTableView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        
        recentTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
}
