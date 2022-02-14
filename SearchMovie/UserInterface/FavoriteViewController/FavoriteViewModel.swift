//
//  FavoriteViewModel.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteViewModel {
    let disposeBag = DisposeBag()
    
    let favoriteTableViewModel = FavoriteTableViewModel()
    
    let favoriteCellData = PublishSubject<[MovieCellData]>()
    let itemSelected = PublishRelay<Int>()
    
    let push: Driver<MovieCellData?>
    
    let title: Driver<String>
    
    init() {
        title = Observable.just("즐겨찾기 목록")
            .asDriver(onErrorJustReturn: "")
        
        // CoreData -> favoriteCellData
        
        favoriteCellData
            .bind(to: favoriteTableViewModel.movieCellData)
            .disposed(by: disposeBag)
        
        self.push = Observable
            .combineLatest(
                favoriteCellData,
                itemSelected
            ).map{ (data, row) in
                return data[row]
            }
            .filter { $0 != nil }
            .asDriver(onErrorDriveWith: .empty())
    }
}
