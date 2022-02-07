//
//  UIImageView.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 06/02/22.
//

import UIKit

extension UIImageView {
    static func photoImageView(named: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }
}
