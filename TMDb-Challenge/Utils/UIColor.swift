//
//  UIColor.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 06/02/22.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let mobile2you = UIColor.rgb(red: 0, green: 79, blue: 145)
}
