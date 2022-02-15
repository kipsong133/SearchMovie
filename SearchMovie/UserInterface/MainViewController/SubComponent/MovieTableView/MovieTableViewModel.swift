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
    
    let movieCellData = PublishSubject<[MovieCellData]>()
    
    let cellData: Driver<[MovieCellData]>
    
    let searchButtonTapped = PublishRelay<Void>()
    
    let favoriteButtonTapped = PublishRelay<Int>()

    let addFavoriteMovies = PublishRelay<Void>()
    
    init(storage: FavoriteStorageType) {
        self.cellData = self.movieCellData
            .asDriver(onErrorJustReturn: [])

        _ = Observable
            .combineLatest(
                favoriteButtonTapped,
                cellData.asObservable()
            ).map { (row, cellData) in
                _ = storage.isContain(content: cellData[row]) ?
                storage.delete(cellData: cellData[row])
                : storage.addFavorite(content: cellData[row])
            }
            .bind(to: self.addFavoriteMovies)
            .disposed(by: disposeBag)
    }
}
