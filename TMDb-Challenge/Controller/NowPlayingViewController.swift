//
//  NowPlayingViewController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "MovieCell"

class NowPlayingViewController: UICollectionViewController {
    // MARK: - Properties
    var movies: [Movie] = []
    var loadingMovies = false
    var currentPage: Int = 1
    
    // MARK: = Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNowPlaying()
    }
    
    // MARK: - API
    func fetchNowPlaying() {
        loadingMovies = true
        TheMovieDBService.shared.fetchNowPlaying(page: currentPage) { (info) in
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
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        title = "Now Playing"
    }
}

// MARK: - UICollectionViewDelegate/DataSource
extension NowPlayingViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        
        if let urlPoster = URL(string: "\(movies[indexPath.row].getImagePosterPath())") {
            cell.movieImageView.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.movieImageView.image = UIImage(named: "notimage")
        }
        return cell
    }
    
    func collecioView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Utilities().sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Utilities().sectionInsets.left
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 && !loadingMovies {
            currentPage += 1
            if movies.count > 0 {
                fetchNowPlaying()
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
extension NowPlayingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Utilities().sectionInsets.left * (Utilities().itemsPerRow - 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Utilities().itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
}
