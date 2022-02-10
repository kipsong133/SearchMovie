//
//  SearchBarViewModel.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import Foundation
import RxSwift
import RxCocoa

class SearchTextFieldViewModel {
    
    let queryText = PublishRelay<String?>()
    
    let returnButtonTapped = PublishRelay<Void>()
    
    var shouldLoadResult: Observable<String>
    
    init() {
        self.shouldLoadResult = returnButtonTapped
            .withLatestFrom(self.queryText) { $1 ?? ""}
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
