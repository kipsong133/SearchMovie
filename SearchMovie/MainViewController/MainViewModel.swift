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
    
//    let cellData: Driver<[MovieCellData]>
    
    init() {
        
        let movieResult = searchTextFieldViewModel.shouldLoadResult
//            .flatMapLatest { query in
//
//                print(query)
//            }
//            .share()
        
        let  movies = [
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0),
            MovieCellData(thumbnailURL: nil, name: "a", filmDirector: "a", performer: "a", rating: 1.0)
        ]
        
        Observable<[MovieCellData]>.create({ observer in
            observer.onNext(movies)
            return Disposables.create()
        })
            .bind(to: movieTableViewModel.movieCellData)
            .disposed(by: disposeBag)
    }
    
}

