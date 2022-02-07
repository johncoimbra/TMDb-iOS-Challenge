//
//  Similar.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 06/02/22.
//

import Foundation

struct Similar: Codable {
    var page: Int? = 0
    var results: [SimilarMovies]? = []
    var total_pages: Int? = 0
    var total_results: Int? = 0
}

struct SimilarMovies: Codable {
    var id: Int? = 0
    var poster_path: String? = ""
    var adult: Bool? = false
    var overview: String? = ""
    var release_date: String? = ""
    var genre_ids: [Int]? = []
    var original_title: String? = ""
    var original_linguage: String? = ""
    var title: String? = ""
    var backdrop_path: String? = ""
    var popularity: Double? = 0.0
    var vote_count: Int? = 0
    var video: Bool? = false
    var vote_average: Double? = 0.0
    
    func getImagePosterPath() -> String {
        guard let poster_path = poster_path else{return ""}
        let urlFull = "\(POSTER_URL)\(poster_path)"
        return urlFull
    }
}

struct GenreResponse: Codable {
    var genres: [GenreMovies]
}

struct GenreMovies: Codable {
    var id: Int;
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
