//
//  SlidePhotoViewController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 08/02/22.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "cellId"

class SlidePhotoMoviesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var movie_id: Int? = 0
    var similarMovies: [SimilarMovies] = []
    var currentPage: Int = 1
    var loadingMovies = false
    var showNames: [String] = []
    private var genreListArray: [GenreMovies] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.register(SlidePhotoMoviesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        fetchSimilarMovies()
        fetchGenresMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - API
    func fetchSimilarMovies() {
        loadingMovies = true
        TheMovieDBService.shared.fetchSimilarMovies(movie_id: movie_id!, page: currentPage) { (info) in
            if let info = info {
                self.similarMovies.append(contentsOf: info.results ?? [])
                print("Inserted", self.similarMovies.count)
                DispatchQueue.main.async {
                    self.loadingMovies = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func fetchGenresMovies() {
        TheMovieDBService.shared.fetchGenreMovies(movie_id: movie_id!) { (info) in
            if let info = info {
                self.genreListArray = info.genres
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SlidePhotoMoviesCell
       
        let itensListArray = self.similarMovies[indexPath.row].genre_ids
        self.showNames.removeAll()
        for listGenresOfItem in itensListArray {
            for genreName in self.genreListArray {
                if genreName.id == listGenresOfItem {
                    self.showNames.append(genreName.name)
                }
            }
        }
        
        let fullData = similarMovies[indexPath.row].release_date
        let fullNameArray = fullData?.components(separatedBy: "-")
        let years = fullNameArray?[0]
        
        let genres1 = showNames.description.replacingOccurrences(of: "[", with: "")
        let genres2 = genres1.replacingOccurrences(of: "]", with: "")
        let genres3 = genres2.replacingOccurrences(of: "\"", with: "")
        
        cell.titleMovie.text = "\(similarMovies[indexPath.row].title ?? "")"
        cell.yearMovie.text = years
        cell.genreMovie.text = genres3
        
        if let urlPoster = URL(string: "\(similarMovies[indexPath.row].getImagePosterPath())") {
            cell.imageSimilarMovies.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.imageSimilarMovies.image = UIImage(named: "notimage")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == similarMovies.count - 1 && !loadingMovies {
            currentPage += 1
            
            if similarMovies.count > 0 {
                fetchSimilarMovies()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 20, bottom: 5, right: 20)
    }
}
