//
//  FavoriteTableViewModel.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteTableViewModel {
    let disposeBag = DisposeBag()
    
    var favoriteList: Observable<[MovieCellData]>
    let movieCellData = PublishSubject<[MovieCellData]>()
    
    let cellData: Driver<[MovieCellData]>
    
    init(storage: FavoriteStorageType) {
        
        self.favoriteList = storage.favoriteList()
//        favoriteList
//            .bind(to: movieCellData)
//            .disposed(by: disposeBag)
        
        cellData = favoriteList
            .asDriver(onErrorJustReturn: [])
    }
}
