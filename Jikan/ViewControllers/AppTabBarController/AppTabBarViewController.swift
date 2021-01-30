//
//  AppTabBarViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import UIKit

class AppTabBarViewController: UITabBarController {
    static var shared = AppTabBarViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUpViewControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViewControllers() {
        let topNavigation = UINavigationController(rootViewController: TopViewController())
        viewControllers = [topNavigation, FavoriteViewController()]
    }
}

extension AppTabBarViewController {
    enum BarItem: Int {
        case top = 0
        case favorite = 1
        
        var tabBarItem: UITabBarItem {
            return UITabBarItem(title: title, image: image, tag: rawValue)
        }
        
        var title: String? {
            switch self {
            case .top:
                return "Top"
            case .favorite:
                return "Favorite"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .top:
                return Images.TabBar.top
            case .favorite:
                return Images.TabBar.favorite
            }
        }
    }
}
