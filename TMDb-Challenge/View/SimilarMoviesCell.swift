//
//  SimilarMoviesCell.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit

class SimilarMoviesCell: UICollectionViewCell {
    var titleSimilarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Similares"
        label.textColor = .white
        return label
    }()
    
    var movie_id: Int? = 0
    var similarMovies: [SimilarMovies]? = []
    var sliderPhotoMoviesVC = SlidePhotoMoviesViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSimilar() {
        
        addSubview(titleSimilarLabel)
        titleSimilarLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddinRight: 20)
        
        addSubview(sliderPhotoMoviesVC.view)
        sliderPhotoMoviesVC.view?.anchor(top: titleSimilarLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)

        sliderPhotoMoviesVC.movie_id = movie_id
        sliderPhotoMoviesVC.similarMovies = similarMovies ?? []
    }
    
    func changeText() {
        if similarMovies?.count == 0 {
            titleSimilarLabel.text = "Não possui filmes similares"
        } else {
            titleSimilarLabel.text = "Similares"
        }
    }
}
