//
//  SearchMovieNetwork.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/11.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchMovieNetworkError: Error {
    case invalidJSON
    case networkError
    case invalidURL
}

class SearchMovieNetwork {
    private let session: URLSession
    let api = SearchMovieAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchMovie(query: String)
    -> Single<Result<NaverMovieResponse, SearchMovieNetworkError>> {
        
        guard let url = api.searchMovie(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("euqsn5AqS1DTzFBqKsgb", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("LTxs588F1n", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let movieData = try JSONDecoder().decode(
                        NaverMovieResponse.self,
                        from: data)
                    print(movieData.items.count)
                    return .success(movieData)
                } catch {
                    return .failure(.networkError)
                }
            }
            .catch { _ in
            .just(.failure(.networkError))
            }
            .asSingle()
    }
}
