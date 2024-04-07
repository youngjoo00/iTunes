//
//  BaseViewModel.swift
//  SeSACRxThreads
//
//  Created by youngjoo on 3/30/24.
//

import Foundation
import RxSwift

protocol CommonViewModel: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    func transform(input: Input) -> Output
}
