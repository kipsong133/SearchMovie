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

    let cellData: Driver<[MovieCellData]>
    
    init(favoriteList: Observable<[MovieCellData]>) {
        
        cellData = favoriteList
            .asDriver(onErrorJustReturn: [])
    }
}
