//
//  SearchViewController.swift
//  iTunes
//
//  Created by youngjoo on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {

    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
