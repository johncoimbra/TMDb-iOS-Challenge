//
//  ResultSearchViewController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "TopRatedCell"

class ResultSearchViewController: UICollectionViewController {
    
    //MARK: - Properties
    var name: String?
    var movies: [Movie] = []
    var loadingMovies = false
    var currentPage: Int = 1
    var total = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchSearch()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - API
    func fetchSearch() {
        loadingMovies = true
        TheMovieDBService.shared.fetchSearch(title: name, page: currentPage) { (info) in
            if let info = info {
                self.movies.append(contentsOf: info.results)
                if let totalResults = info.total_results {
                    self.total = totalResults
                    DispatchQueue.main.async {
                        self.loadingMovies = false
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Selectors
    @objc func handleClose() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        title = "Result Search"
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
    }
}

// MARK: - UICollectionViewDelegate/DataSource
extension ResultSearchViewController {
    
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
            cell.topRatedImageView.image = UIImage(named: "notImage")
        }
        
        cell.titleMovie.text = "\(movies[indexPath.row].title?.description ?? "")"
        cell.overviewMovie.text = "\(movies[indexPath.row].overview?.description ?? "")"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 && !loadingMovies {
            currentPage += 1
            if movies.count > 0 {
                fetchSearch()
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
extension ResultSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
