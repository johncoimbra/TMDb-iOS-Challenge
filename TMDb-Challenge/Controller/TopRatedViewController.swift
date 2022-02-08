//
//  TopRatedViewController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "TopRatedCell"

class TopRatedViewController: UICollectionViewController {
    
    // MARK: - Properties
    var movies: [Movie] = []
    var loadingMovies = false
    var currentPage: Int = 1

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTopRated()
    }
    
    // MARK: - API
    func fetchTopRated() {
        loadingMovies = true
        TheMovieDBService.shared.fetchTopRated(page: currentPage) { (info) in
            if let info = info {
                self.movies.append(contentsOf: info.results)
                print("Inserted", self.movies.count)
                DispatchQueue.main.async {
                    self.loadingMovies = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        title = "Top Rated"
    }
}

// MARK: - UICollectionViewDelegate/DataSource
extension TopRatedViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TopRatedCell
        if let urlPoster = URL(string: "\(movies[indexPath.row].getImagePosterPath())") {
            cell.topRatedImageView.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.topRatedImageView.image = UIImage(named: "spider")
        }
        
        cell.titleMovie.text = "\(movies[indexPath.row].title?.description ?? "")"
        cell.overviewMovie.text = "\(movies[indexPath.row].overview?.description ?? "")"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 && !loadingMovies {
            currentPage += 1
            if movies.count > 0 {
                fetchTopRated()
            }
            print("Loading more movies")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsMovieViewController()
        controller.movie_id = movies[indexPath.row].id
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TopRatedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

