//
//  SearchTableViewCell.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import Then
import RxSwift
import Kingfisher

final class SearchTableViewCell: BaseTableViewCell {
    
    let iconImageView = CornerRadiusImageView(frame: .zero).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let titleLabel = UILabel()
    let downloadButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    let ratingImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
    }
    
    let ratingLabel = UILabel()
    let sellerLabel = UILabel()
    let genresLabel = UILabel()
    
    let appImageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let firstAppImageView = CornerRadiusImageView(frame: .zero)
    let secondAppImageView = CornerRadiusImageView(frame: .zero)
    let thirdAppImageView = CornerRadiusImageView(frame: .zero)
    
    override func configureHierarchy() {
        [
            iconImageView,
            titleLabel,
            downloadButton,
            ratingImageView,
            ratingLabel,
            sellerLabel,
            genresLabel,
            appImageStackView
        ].forEach { contentView.addSubview($0) }
        
        [
            firstAppImageView,
            secondAppImageView,
            thirdAppImageView
        ].forEach { appImageStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(5)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-5)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.leading.equalTo(iconImageView)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView)
            make.leading.equalTo(ratingImageView.snp.trailing).offset(5)
        }
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        ratingLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        sellerLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualTo(ratingLabel.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(genresLabel.snp.leading).offset(-10)
        }
        sellerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        sellerLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

       
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView)
            make.trailing.equalTo(downloadButton)
        }
        genresLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        genresLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        appImageStackView.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(250)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}


extension SearchTableViewCell {
    
    func updateCell(_ element: AppResult) {
        let iconImageURL = URL(string: element.artworkUrl512)
        iconImageView.kf.setImage(with: iconImageURL)
        
        titleLabel.text = element.trackName
        ratingLabel.text = element.averageUserRating.singleDigitString
        sellerLabel.text = element.sellerName
        genresLabel.text = element.genres[0]
        
        for (index, urlString) in element.screenshotUrls[0...2].enumerated() {
            let url = URL(string: urlString)
            let appImageView = appImageStackView.arrangedSubviews[index] as? UIImageView
            
            appImageView?.kf.setImage(with: url)
        }
    }
}
