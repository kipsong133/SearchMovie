//
//  MainViewModel.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    let disposeBag = DisposeBag()
    
    let movieTableViewModel = MovieTableViewModel()
    let searchTextFieldViewModel = SearchTextFieldViewModel()
    
    init() {
        
        let movieResult = searchTextFieldViewModel.shouldLoadResult
//            .flatMapLatest { query in
//
//                print(query)
//            }
//            .share()
        
        
    }
    
}

