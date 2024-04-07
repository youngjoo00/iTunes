//
//  DetailSearchView.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import Then

final class DetailSearchView: BaseView {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let iconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    let downloadButton = UIButton().then {
        $0.backgroundColor = .gray
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    // MARK: - Info
    let infoScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    let infoContentView = UIView()
    
    let infoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let ratingImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
    }
    
    let ratingLabel = UILabel()
    let sellerLabel = UILabel()
    let genresLabel = UILabel()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(DetailSearchCollectionViewCell.self, forCellWithReuseIdentifier: DetailSearchCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            iconImageView,
            titleLabel,
            downloadButton,
            separatorView,
            infoScrollView,
            collectionView,
            descriptionLabel,
        ].forEach { contentView.addSubview($0) }

        infoScrollView.addSubview(infoStackView)
        
        [
            ratingImageView,
            ratingLabel,
            sellerLabel,
            genresLabel
        ].forEach { infoStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(iconImageView)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(44)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(downloadButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1)
        }
        
        infoScrollView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.edges.equalTo(infoScrollView)
        }
     
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(infoScrollView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func configureView() {
        
    }
    
}

extension DetailSearchView {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        
        let cellWidth = UIScreen.main.bounds.width * 0.5
        let cellhieght = CGFloat(300)
        
        layout.itemSize = CGSize(width: cellWidth, height: cellhieght)
        //layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
