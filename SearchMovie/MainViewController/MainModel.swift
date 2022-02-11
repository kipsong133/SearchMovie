//
//  MainModel.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import Foundation
import RxSwift



class MainModel {
    let network = SearchMovieNetwork()
    
    func searchBlog(_ query: String)
    -> Single<Result<NaverMovieResponse, SearchMovieNetworkError>> {
        return network.searchMovie(query: query)
    }
    
    func getMovieValue(_ response: Result<NaverMovieResponse,
                       SearchMovieNetworkError>)
    -> NaverMovieResponse? {
        guard case .success(let value) = response else { return nil }
        return value
    }
    
    func getMovieError(_ response: Result<NaverMovieResponse,
                       SearchMovieNetworkError>)
    -> String? {
        guard case .failure(let error) = response else { return nil }
        return error.localizedDescription
    }
    
    func getMovieCellData(_ value: NaverMovieResponse) -> [MovieCellData] {
        return value.items
            .map { movie in
                let thumbnailURL = URL(string: movie.thumbnailImageURLStr ?? "")
                return MovieCellData(
                    thumbnailURL: thumbnailURL,
                    name: movie.title,
                    filmDirector: movie.director,
                    performer: movie.actor,
                    rating: movie.userRating)
            }
            
    }
}
