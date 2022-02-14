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

class CoreDataStorage: FavoriteStorageType {
    let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    @discardableResult
    func addFavorite(content: MovieCellData) -> Observable<MovieCellData> {
        let favorite = MovieCellData(content: content)
        
        do {
            _ = try mainContext.rx.update(favorite)
            return Observable.just(favorite)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func favoriteList() -> Observable<[MovieCellData]> {
//        return mainContext.rx.entities(
//            MovieCellData.self,
//            sortDescriptors: [NSSortDescriptor(key: "identity", ascending: false)])
        return mainContext.rx.entities(MovieCellData.self, predicate: nil, sortDescriptors: nil)
    }
    
    @discardableResult
    func delete(cellData: MovieCellData) -> Observable<MovieCellData> {
        do {
            try mainContext.rx.delete(cellData)
            return Observable.just(cellData)
        } catch {
            return Observable.error(error)
        }
    }
}
