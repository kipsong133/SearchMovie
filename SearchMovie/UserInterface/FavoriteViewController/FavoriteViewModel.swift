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

    let favoriteTableViewModel: FavoriteTableViewModel
    
    let favoriteCellData: Observable<[MovieCellData]>
    let itemSelected = PublishRelay<Int>()

    let pushDetail: Driver<MovieCellData?>
    
    let title: Driver<String>
    
    init(storage: FavoriteStorageType) {
        favoriteCellData = storage.favoriteList()
        self.favoriteTableViewModel = FavoriteTableViewModel(favoriteList: favoriteCellData)
        
        title = Observable.just("즐겨찾기 목록")
            .asDriver(onErrorJustReturn: "")
        
        self.pushDetail = Observable
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
