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
    
    let movieCellData = PublishSubject<[MovieCellData]>()
    
    let cellData: Driver<[MovieCellData]>
    
    init() {
        cellData = movieCellData
            .asDriver(onErrorJustReturn: [])
    }
}
