//
//  TopViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import UIKit

class TopViewController: BasedViewController<TopViewModel> {
    
    lazy var tableView: AnimeTableView = {
        let tableview = AnimeTableView()
        tableview.viewController = self
        return tableview
    }()
    
    // MARK: Object life cycle
    init() {
        super.init(viewModel: TopViewModel())
        tabBarItem = AppTabBarViewController.BarItem.top.tabBarItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.Top.typePicker, style: .plain, target: self, action: #selector(onTypePickerButtonTap))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchTopAnimes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.onAnimesFetch = { [weak self] (error) in
            if let error = error {
                // error handeling
            } else {
                self?.tableView.animes = self?.viewModel.animes ?? []
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onTypeReset = { [weak self] in
            self?.tableView.animes = self?.viewModel.animes ?? []
            self?.tableView.reloadData()
            self?.updateTitle()
        }
    }
    
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
        
        updateTitle()
        view.backgroundColor = .secondarySystemBackground
        
        view.addFilledSubView(tableView)
    }
    
    private func updateTitle() {
        title = "\(viewModel.type.text) - \(viewModel.subType?.text ?? "All")"
        tabBarItem = AppTabBarViewController.BarItem.top.tabBarItem
    }
    
    // MARK: User action
    @objc private func onTypePickerButtonTap() {
        let typePickerPage = TypePickerViewController(selectedType: viewModel.type, selectedSubType: viewModel.subType)
        typePickerPage.delegate = self
        present(typePickerPage, animated: true, completion: nil)
    }
}

extension TopViewController: AnimeTableViewDelegate, TypePickerViewControllerDelegate {
    func loadMoreContent() {
        viewModel.fetchTopAnimes()
    }
    
    func updateFavoriteAnime(at index: Int) {
        tableView.reloadData()
    }
    
    func didAnimeTypePicked(type: Anime.MainType, subType: Anime.SubType?) {
        viewModel.resetTypeAndSubType(type: type, subType: subType)
    }
}
