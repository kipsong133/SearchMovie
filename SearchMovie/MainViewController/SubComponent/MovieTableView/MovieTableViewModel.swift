//
//  MovieTableViewModel.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import Foundation
import RxSwift
import RxCocoa



class MovieTableViewModel {
    
    let movieCellData = PublishRelay<[MovieCellData]>()
    
    let cellData: Driver<[MovieCellData]>
    
    init() {
        self.cellData = self.movieCellData
            .asDriver(onErrorJustReturn: [])
    }
}