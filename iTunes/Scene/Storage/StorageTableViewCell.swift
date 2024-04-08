//
//  StorageTableView.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import UIKit
import Then
import Kingfisher

final class StorageTableViewCell: BaseTableViewCell {
    
    let iconImageView = CornerRadiusImageView(frame: .zero)
    let title = UILabel()
    let regDateLabel = UILabel()
    
    override func configureHierarchy() {
        [
            iconImageView,
            title,
            regDateLabel,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.size.equalTo(60)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.top.equalTo(iconImageView.snp.top).offset(10)
        }
        
        regDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(iconImageView)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
    }
    
    override func configureView() {
        
    }
}

extension StorageTableViewCell {
    
    func updateCell(_ data: AppInfo) {
        let url = URL(string: data.iconImage)
        iconImageView.kf.setImage(with: url)
        
        title.text = data.title
        regDateLabel.text = DateManager.shared.formatDateString(date: data.regDate)
    }
}
