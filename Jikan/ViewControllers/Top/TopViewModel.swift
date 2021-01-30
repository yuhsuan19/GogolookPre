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
    var animes: [Anime] = []
    var onAnimesFetch: ((Error?) -> Void)?
    
    func fetchTopAnimes() {
        isLoading = true
        
        networkServiceProvider.request(for: JikanAPI.top(type: "anime", page: nil, subtype: nil)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let newAnimes = try? JSONDecoder().decode(TopAnimesData.self, from: response.data) else {
                    print("parsing error")
                    return
                }
                
                print(newAnimes)
                
            case .failure(let error):
                break
            }
            self?.isLoading = false
        }
    }
}

// MARK: Data decoder
extension TopViewModel {
    struct TopAnimesData: Decodable {
        var top: [Anime]
    }
}
