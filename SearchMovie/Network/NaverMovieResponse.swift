//
//  NaverMovieResponse.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/11.
//

import Foundation



struct NaverMovieResponse: Decodable {
    let items: [Movie]

}

struct Movie: Decodable {
    let title: String?
    let link: String?
    let thumbnailImageURLStr: String?
    let subtitle: String?
    let director: String?
    let actor: String?
    let userRating: String?
    
    enum CodingKeys: String, CodingKey {
        case title, link, subtitle, director, actor, userRating
        case thumbnailImageURLStr = "image"
    }
}
