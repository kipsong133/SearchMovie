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
    
    let movieTableViewModel = MovieTableViewModel()
    let searchTextFieldViewModel = SearchTextFieldViewModel()
    
    let refreshValueChanged = PublishRelay<Void>()
    
    let push: Driver<MovieCellData?>
    
    let modal = PublishSubject<Void>()
    
    let itemSelected = PublishRelay<Int>()

    init(model: MainModel = MainModel()) {
        
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
        
        self.push = Observable
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

