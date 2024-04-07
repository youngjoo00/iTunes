//
//  CurrentCollectionViewCell.swift
//  iTunes
//
//  Created by youngjoo on 4/7/24.
//

import UIKit
import Then
import RxSwift

final class RecentTableViewCell: BaseTableViewCell {
    
    let recentLabel = UILabel()
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    
    override func configureHierarchy() {
        [
            recentLabel,
            deleteButton,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        recentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(deleteButton).offset(-10)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}

extension RecentTableViewCell {
    
    func updateCell(_ data: String) {
        recentLabel.text = data
    }
}
