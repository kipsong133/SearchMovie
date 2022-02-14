//
//  CoreDataStorage.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import Foundation
import RxSwift
import RxCoreData
import CoreData

protocol FavoriteStorageType {
    @discardableResult
    func addFavorite(content: MovieCellData) -> Observable<MovieCellData>
    
    @discardableResult
    func memoList() -> Observable<[MovieCellData]>

    @discardableResult
    func delete(memo: MovieCellData) -> Observable<MovieCellData>
}



