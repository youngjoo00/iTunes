//
//  DetailSearchCollectionViewCell.swift
//  iTunes
//
//  Created by youngjoo on 4/7/24.
//

import UIKit
import Then
import RxSwift
import Kingfisher

final class DetailSearchCollectionViewCell: BaseCollectionViewCell {
    
    let screenshotImageView = CornerRadiusImageView(frame: .zero)
    
    override func configureHierarchy() {
        [
            screenshotImageView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        screenshotImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}


extension DetailSearchCollectionViewCell {
    
    func updateCell(_ urlString: String) {
        let url = URL(string: urlString)
        screenshotImageView.kf.setImage(with: url)
    }
}
