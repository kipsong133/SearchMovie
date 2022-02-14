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
    
    let storage: FavoriteStorageType
    
    let movieTableViewModel: MovieTableViewModel
    let searchTextFieldViewModel: SearchTextFieldViewModel
    
    let refreshValueChanged = PublishRelay<Void>()
    
    let pushDetail: Driver<MovieCellData?>
    
    let pushFavorite = PublishSubject<Void>()
    
    let itemSelected = PublishRelay<Int>()

    init(storage: FavoriteStorageType,
         tableViewModel: MovieTableViewModel,
         textFieldViewModel: SearchTextFieldViewModel,
         model: MainModel = MainModel()) {
        
        self.storage = storage
        self.movieTableViewModel = tableViewModel
        self.searchTextFieldViewModel = textFieldViewModel
        
        let movieResult = searchTextFieldViewModel.shouldLoadResult
            .flatMapLatest { query in
                model.searchBlog(query)
                
            }
            .share()
        
        let movieValue = movieResult
            .compactMap { response -> NaverMovieResponse? in
                model.getMovieValue(response)
            }
        
        // error
        _ = movieResult
            .compactMap { response -> String? in
                model.getMovieError(response)
            }
        
        
        let cellData = movieValue
            .map { movie -> [MovieCellData] in
                model.getMovieCellData(movie)
            }
        
        cellData
            .bind(to: movieTableViewModel.movieCellData)
            .disposed(by: disposeBag)
        
        searchTextFieldViewModel.returnButtonTapped
            .withLatestFrom(cellData)
            .map { _ in }
            .bind(to: movieTableViewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        self.pushDetail = Observable
            .combineLatest(
                cellData,
                itemSelected
            ).map { (cellData, row) in
                return cellData[row]
            }
            .filter { $0 != nil }
            .asDriver(onErrorDriveWith: .empty())
    }
}

