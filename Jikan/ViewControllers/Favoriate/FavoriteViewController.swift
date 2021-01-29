//
//  FavoriateViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import UIKit

class FavoriteViewController: BasedViewController<FavoriteViewModel> {
    
    init() {
        super.init(viewModel: FavoriteViewModel())
        tabBarItem = AppTabBarViewController.BarItem.favorite.tabBarItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
    }
}
