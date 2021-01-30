//
//  TopViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import UIKit

class TopViewController: BasedViewController<TopViewModel> {
    
    lazy var tableView = AnimeTableView()
    
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
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.onAnimesFetch = { [weak self] (error) in
            if let error = error {
                // error handeling
            } else {
                self?.tableView.animes = self?.viewModel.animes ?? []
            }
        }
    }
    
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
        
        view.backgroundColor = .secondarySystemBackground
        
        view.addFilledSubView(tableView)
    }
    
    // MARK: User action
    @objc private func onTypePickerButtonTap() {
        let typePickerPage = TypePickerViewController()
        present(typePickerPage, animated: true, completion: nil)
    }
}
