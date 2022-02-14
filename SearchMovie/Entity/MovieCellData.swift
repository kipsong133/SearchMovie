//
//  MovieCellData.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import Foundation
import RxCoreData
import CoreData

struct MovieCellData {
    let thumbnailURL: URL?
    let name: String?
    let filmDirector: String?
    let performer: String?
    let rating: String?
    let link: String?
    var insertDate: Date
    var identity: String
    
    init(thumbnailURL: URL?,
         name: String?,
         filmDirector: String?,
         performer: String?,
         rating: String?,
         link: String?,
         insertDate: Date = Date()) {
        self.thumbnailURL = thumbnailURL
        self.name = name
        self.filmDirector = filmDirector
        self.performer = performer
        self.rating = rating
        self.link = link
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(content: MovieCellData, insertDate: Date = Date()) {
        self = content
    }
}

extension MovieCellData: Persistable {
    static var entityName: String {
        return "FavoriteMovies"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity: NSManagedObject) {
        thumbnailURL = entity.value(forKey: "thumbnailURL") as! URL
        name = entity.value(forKey: "name") as! String
        filmDirector = entity.value(forKey: "filmDirector") as! String
        performer = entity.value(forKey: "performer") as! String
        rating = entity.value(forKey: "rating") as! String
        link = entity.value(forKey: "link") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
        
    }
    
    func update(_ entity: NSManagedObject) {
//        entity.setValue(content, forKey: "content")
//        entity.setValue(insertDate, forKey: "insertDate")
//        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")
//
//        do {
//            try entity.managedObjectContext?.save()
//        } catch {
//            print(error)
//        }
    }
    
}
