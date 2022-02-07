//
//  MovieDetails.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 06/02/22.
//

import Foundation
import CoreText

struct MovieDetails: Codable {
    var adult: Bool? = false
    var backgroud_path: String? = ""
    var budget: Int? = 0
    var genres: [Genres]? = []
    var homepage: String? = ""
    var id: Int? = 0
    var imdb_id: String? = ""
    var original_language: String?
    var original_title: String? = ""
    var overview: String? = ""
    var popularity: Double = 0.0
    var poster_path: String? = ""
    var release_data: String? = ""
    var revenue: Int? = 0
    var runtime: Int? = 0
    var spoken: [Spoken]? = []
    var status: String? = ""
    var title: String? = ""
    var video: Bool? = false
    var vote_average: Double? = 0.0
    var vote_count: Int? = 0
    
    func getImageBackDropPath() -> String {
        guard let backdrop_path = backgroud_path else {return ""}
        let urlFull = "\(POSTER_URL)\(backdrop_path)"
        return urlFull
    }
}

struct Genres: Codable {
    var id: Int? = 0
    var name: String? = ""
}

struct Production: Codable {
    var name: String? = ""
    var id: Int? = 0
    var logo_path: String? = ""
    var origin_country: String? = ""
}

struct Coutries: Codable {
    var iso_3166_1: String? = ""
    var name: String? = ""
}

struct Spoken: Codable {
    var iso_639_1: String? = ""
    var name: String? = ""
}
