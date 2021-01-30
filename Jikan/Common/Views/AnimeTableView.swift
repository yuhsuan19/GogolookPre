//
//  AnimeTableView.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import UIKit

class AnimeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var animes: [Anime] = [] {
        didSet {
            reloadData()
        }
    }
    
    // MARK: Object life cycle
    init() {
        super.init(frame: .zero, style: .plain)
        translatesAutoresizingMaskIntoConstraints = false
        register(AnimeTableViewCell.self, forCellReuseIdentifier: "Anime")
        delegate = self
        dataSource = self
        backgroundColor = .clear
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableView delegate and data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.basedOnScreenWidth()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Anime", for: indexPath) as! AnimeTableViewCell
        return cell
    }
}
