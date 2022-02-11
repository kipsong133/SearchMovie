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
    let disposeBag = DisposeBag()
    
    let movieCellData = BehaviorSubject<[MovieCellData]>(value: [MovieCellData(thumbnailURL: nil, name: "TESt", filmDirector: "TESt", performer: "TESt", rating: 1.0)])
    
    let cellData: Driver<[MovieCellData]>
    
    init() {
        self.cellData = self.movieCellData
            .asDriver(onErrorJustReturn: [])
    }
}
