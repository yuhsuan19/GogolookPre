//
//  FavoriateViewModel.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import Foundation

class FavoriteViewModel: BasedViewModel {
    
    var onAnimesFetch: (() -> Void)?
    var animes: [Anime] = []
    
    
    func fetchLocalAnimes() {
        animes = AnimeDocument.fetchLocalAnimes()
        onAnimesFetch?()
    }
    
    var onAnimeRemove: ((Int) -> Void)?
    func removeAnime(at index: Int) {
        animes.remove(at: index)
        onAnimeRemove?(index)
    }
}
