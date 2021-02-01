//
//  TopViewModel.swift
//  Jikan
//
//  Created by CHI on 2021/1/29.
//

import Foundation
import UIKit
class TopViewModel: BasedViewModel {
    
    // MARK: Fetch top animes
    var type: Anime.MainType = .anime
    var subType: Anime.SubType? = nil
    var page: Int = 1
    var isLoadAll: Bool = false
    
    var animes: [Anime] = []
    var onAnimesFetch: ((Error?) -> Void)?
    
    func fetchTopAnimes() {
        guard !isLoadAll, !isLoading else {
            return
        }
        isLoading = true
        networkServiceProvider.request(for: JikanAPI.top(type: type, page: page, subtype: subType)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let parsedData = try? JSONDecoder().decode(TopAnimesData.self, from: response.data) else {
                    self?.onAnimesFetch?(AppError.networkFailed)
                    return
                }
                self?.isLoadAll = parsedData.top.count < 50
                self?.animes.append(contentsOf: parsedData.top)
                self?.onAnimesFetch?(nil)
                
            case .failure(let error):
                self?.onAnimesFetch?(error)
            }
            self?.isLoading = false
        }
    }
    
    var onTypeReset: (() -> Void)?
    func resetTypeAndSubType(type: Anime.MainType, subType: Anime.SubType?) {
        self.type = type
        self.subType = subType
        page = 1
        isLoadAll = false
        isLoading = false
        animes.removeAll()
        
        onTypeReset?()
        fetchTopAnimes()
    }
}

// MARK: Data decoder
extension TopViewModel {
    struct TopAnimesData: Decodable {
        var top: [Anime]
    }
}
