//
//  MemoryStorage.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import Foundation
import RxSwift

class MemoryStorage: FavoriteStorageType {
    
    private var list = [MovieCellData]()
    
    private lazy var store = BehaviorSubject<[MovieCellData]>(value: list)
    
    @discardableResult
    func isContain(content: MovieCellData) -> Bool {
        let cellData = MovieCellData(content: content)
        if list.firstIndex(where: { $0.identity == cellData.identity }) != nil {
            return true
        } else {
            return false
        }
    }
    
    
    @discardableResult
    func addFavorite(content: MovieCellData) -> Observable<MovieCellData> {
        let cellData = MovieCellData(content: content)
        self.list.append(cellData)
        store.onNext(list)
        print(content)
        return Observable.just(cellData)
    }
    
    @discardableResult
    func favoriteList() -> Observable<[MovieCellData]> {
        print(list)
        return store
    }
    
    @discardableResult
    func delete(cellData: MovieCellData) -> Observable<MovieCellData> {
        if let index = list.firstIndex(where: { $0.identity == cellData.identity }) {
            self.list.remove(at: index)
        }
        
        store.onNext(list)
        return Observable.just(cellData)
    }
    
    
}
