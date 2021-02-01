//
//  FavoriateViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import UIKit

class FavoriteViewController: BasedViewController<FavoriteViewModel> {
    lazy var tableView: AnimeTableView = {
        let tableView = AnimeTableView()
        tableView.viewController = self
        return tableView
    }()
    
    // MARK: Object life cycle
    init() {
        super.init(viewModel: FavoriteViewModel())
        tabBarItem = AppTabBarViewController.BarItem.favorite.tabBarItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLocalAnimes()
    }
    
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
        title = "Favorite"
        view.backgroundColor = .secondarySystemBackground
        
        view.addFilledSubView(tableView)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.onAnimesFetch = { [weak self] in
            self?.tableView.animes = self?.viewModel.animes ?? []
            self?.tableView.reloadData()
        }

        viewModel.onAnimeRemove = { [weak self] (index) in
            self?.tableView.animes = self?.viewModel.animes ?? []
            self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        }
    }
}

extension FavoriteViewController: AnimeTableViewDelegate {
    
    func loadMoreContent() {
    }
    
    func updateFavoriteAnime(at index: Int) {
        viewModel.removeAnime(at: index)
    }
}
