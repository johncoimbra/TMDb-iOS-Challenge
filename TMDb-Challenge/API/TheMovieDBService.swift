//
//  TheMovieDBService.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 06/02/22.
//

import Alamofire

class TheMovieDBService {
    static let shared = TheMovieDBService()
    
    // MARK: - Get Now Playing
    func fetchNowPlaying(page: Int, onComplete: @escaping (Movies?) -> Void) {
        let url: String
        url = "\(API_BASE)\(NOW_PLAYING)api_key=\(API_KEY)&page=\(page)"
        print("DEBUG: url Now Playing...: \(url)")
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let nowPlayingInfo = try JSONDecoder().decode(Movies.self, from: data)
                onComplete(nowPlayingInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    // MARK: - Get Popular
    func fetchPopular(page: Int, onComplete: @escaping (Movies?) -> Void) {
        let url: String
        url = "\(API_BASE)\(POPULAR)api_key=\(API_KEY)&page=\(page)"
        print("DEBUG: url Popular...: \(url)")
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let popularInfo = try JSONDecoder().decode(Movies.self, from: data)
                onComplete(popularInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    // MARK: - Get Top Rated
    func fetchTopRated(page: Int, onComplete: @escaping (Movies?) -> Void) {
        let url: String
        url = "\(API_BASE)\(TOP_RATED)api_key=\(API_KEY)&page=\(page)"
        print("DEBUG: url Top Rated...: \(url)")
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let topRatedInfo = try JSONDecoder().decode(Movies.self, from: data)
                onComplete(topRatedInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    // MARK: - Get Search
    func fetchSearch(title: String?, page: Int, onComplete: @escaping (Movies?) -> Void) {
        let query: String
        let url: String
        
        if let name = title, !name.isEmpty {
            query = "query=\(name.replacingOccurrences(of: " ", with: ""))&"
            url = "\(API_BASE)\(NOW_PLAYING)api_key=\(API_KEY)&page=\(page)"
        } else {
            url = "\(API_BASE)\(NOW_PLAYING)api_key=\(API_KEY)&page=\(page)"
        }
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let searchInfo = try JSONDecoder().decode(Movies.self, from: data)
                onComplete(searchInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    //MARK: - Get Details
        func fetchMovieDetails(movie_id: Int, onComplete: @escaping (MovieDetails?) -> Void) {
            let url: String
            url = "\(API_BASE)\(MOVIE)\(movie_id)?api_key=\(API_KEY)"
            print("DEBUG: url...:\(url)")
            
            Alamofire.request(url).responseJSON { (response) in
                guard let data = response.data else {
                    onComplete(nil)
                    return
                }
                do {
                    let nowPlayingInfo = try JSONDecoder().decode(MovieDetails.self, from: data)
                    onComplete(nowPlayingInfo)
                } catch {
                    print(error.localizedDescription)
                    onComplete(nil)
                }
            }
        }
        
        //MARK: - Get Similar Movies
        func fetchSimilarMovies(movie_id: Int, page: Int, onComplete: @escaping (Similar?) -> Void) {
            let url: String
            url = "\(API_BASE)\(MOVIE)\(movie_id)\(SIMILAR)api_key=\(API_KEY)&page=\(page)"
            print("DEBUG: url Similar...:\(url)")
            
            Alamofire.request(url).responseJSON { (response) in
                guard let data = response.data else {
                    onComplete(nil)
                    return
                }
                do {
                    let nowPlayingInfo = try JSONDecoder().decode(Similar.self, from: data)
                    onComplete(nowPlayingInfo)
                } catch {
                    print(error.localizedDescription)
                    onComplete(nil)
                }
            }
        }
    
    // MARK: - Get Genre
    func fetchPopular(movie_id: Int, onComplete: @escaping (GenreResponse?) -> Void) {
        let url: String
        url = "\(API_BASE)\(GENRE)\(MOVIE)\(LIST)api_key=\(API_KEY)"
        print("DEBUG: url Genres...: \(url)")
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let genreInfo = try JSONDecoder().decode(GenreResponse.self, from: data)
                onComplete(genreInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
}
