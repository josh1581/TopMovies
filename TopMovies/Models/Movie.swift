//
//  Movies.swift
//  TopMovies
//
//  Created by Joshua Hoyle on 11/30/21.
//

import UIKit

struct MoviesTopLevelObject: Codable {
    let results: [Movie]
}// End of Struct

public struct Movie: Codable {
    let title: String
    let overview: String
    let poster: String?
    
    
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case title, overview
    }
}// End of Struct
