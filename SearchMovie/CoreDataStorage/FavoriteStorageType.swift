//
//  FavoriteStorageType.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import Foundation
import RxSwift

protocol FavoriteStorageType {
    @discardableResult
    func addFavorite(content: MovieCellData) -> Observable<MovieCellData>
    
    @discardableResult
    func favoriteList() -> Observable<[MovieCellData]>

    @discardableResult
    func delete(cellData: MovieCellData) -> Observable<MovieCellData>
}
