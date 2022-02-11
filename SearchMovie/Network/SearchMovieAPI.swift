//
//  SearchMovieAPI.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/11.
// https://openapi.naver.com/v1/search/movie.json?query=국가

import Foundation

struct SearchMovieAPI {
    static let scheme = "https"
    static let host = "openapi.naver.com"
    static let path = "/v1/search/movie.json"
    
    func searchMovie(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = SearchMovieAPI.scheme
        components.host   = SearchMovieAPI.host
        components.path   = SearchMovieAPI.path
        
        components.queryItems = [
        URLQueryItem(name: "query", value: query)
        ]
        return components
    }
}
