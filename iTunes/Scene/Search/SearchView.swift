//
//  SearchView.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import Then

final class SearchView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.text = "검색"
    }
    
    override func configureHierarchy() {
        [
            titleLabel
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
        }
    }
    
    override func configureView() {
        
    }
    
}
