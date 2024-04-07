//
//  DetailSearchViewController.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class DetailSearchViewController: BaseViewController {

    private let mainView = DetailSearchView()
    private let viewModel = DetailSearchViewModel()
    
    var appInfo: AppResult?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LargeTitle 때문에 계속 레이아웃이 이상하게 잡힌거였음,,
        navigationController?.navigationBar.prefersLargeTitles = false
        bind()
    }
    
    func bind() {
        guard let appInfo else { return }
        
        let input = DetailSearchViewModel.Input(appInfo: appInfo)
        
        let output = viewModel.transform(input: input)

        output.iconImageURL
            .drive(with: self) { owner, url in
                owner.mainView.iconImageView.kf.setImage(with: url)
            }
            .disposed(by: disposeBag)
        
        output.title
            .drive(mainView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.description
            .drive(mainView.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.rating
            .drive(mainView.ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.seller
            .drive(mainView.sellerLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.genre
            .drive(mainView.genresLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.screenshot
            .drive(mainView.collectionView.rx.items(cellIdentifier: DetailSearchCollectionViewCell.identifier,
                                                    cellType: DetailSearchCollectionViewCell.self)) { row, element, cell in
                cell.updateCell(element)
            }
            .disposed(by: disposeBag)
    }
}
