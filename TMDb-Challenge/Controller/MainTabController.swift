//
//  MainTabController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        
        ///Now Playing
        let nowPlaying = NowPlayingViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(systemName: "house"), rootViewController: nowPlaying, title: "Now Playing")
        
        ///Popular
        let popular = PopularViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav2 = templateNavigationController(image: UIImage(systemName: "list.bullet.below.rectangle"), rootViewController: popular, title: "Popular")
        
        ///Top Rated
        let topRated = TopRatedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav3 = templateNavigationController(image: UIImage(systemName: "globe"), rootViewController: topRated, title: "Top Rated")
        
        /// Search
        let search = SearchViewController()
        let nav4 = templateNavigationController(image: UIImage(systemName: "magnifyingglass"), rootViewController: search, title: "Search Movies")
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
    }

}
