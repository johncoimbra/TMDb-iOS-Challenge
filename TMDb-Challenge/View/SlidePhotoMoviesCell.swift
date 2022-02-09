//
//  SliderPhotoMoviesCell.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit

class SlidePhotoMoviesCell: UICollectionViewCell {
    var imageSimilarMovies: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(width: 80, height: 100)
        iv.backgroundColor = .mobile2you
        iv.image = UIImage(named: "notimage")
        return iv
    }()
    
    ///UI Titulo Filme
    var titleMovie: UILabel = {
    let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Nome do filme..."
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    ///UI Ano Filme
    var yearMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "2019"
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.setDimension(width: 50, height: 16)
        return label
    }()
    
    ///UI Genero Filme
    var genreMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Drama, Fantasy"
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(imageSimilarMovies)
        imageSimilarMovies.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [yearMovie, genreMovie])
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 2
        
        let stackView = UIStackView(arrangedSubviews: [titleMovie, stack])
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 2
        
        addSubview(stackView)
        
        stackView.anchor(top: imageSimilarMovies.topAnchor, left: imageSimilarMovies.rightAnchor, right: rightAnchor, paddingTop: 25, paddingLeft: 12, paddinRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
