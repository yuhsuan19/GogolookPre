//
//  AnimeTableView.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import UIKit
import SafariServices

protocol AnimeTableViewDelegate: UIViewController {
    func showContentWith(url: URL?)
    func loadMoreContent()
    func updateFavoriteAnime(at index: Int)
}

extension AnimeTableViewDelegate {
    func showContentWith(url: URL?) {
        guard let url = url else {
            // error handling
            return
        }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}

class AnimeTableView: UITableView, UITableViewDelegate, UITableViewDataSource, AnimeTableViewCellDelegate {
    weak var viewController: AnimeTableViewDelegate?
    
    var animes: [Anime] = []
    
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
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Anime", for: indexPath) as! AnimeTableViewCell
        cell.anime = animes[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.showContentWith(url: animes[indexPath.row].contentURL)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row > animes.count - 8) {
            viewController?.loadMoreContent()
        }
    }
    
    func didActionButtonTapped(in cell: AnimeTableViewCell) {
        guard let index = indexPath(for: cell)?.row else {
            return
        }
        
        let anime = animes[index]
        
        if anime.isFavorite {
            AnimeDocument.deleteLocalAnime(with: anime.mal_id)
        } else {
            let animeDocument = AnimeDocument(anime: anime)
            animeDocument?.save()
        }
        
        viewController?.updateFavoriteAnime(at: index)
    }
}
