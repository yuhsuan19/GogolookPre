//
//  FavoriteViewControllerTests.swift
//  JikanTests
//
//  Created by CHI on 2021/2/1.
//

import XCTest
@testable import Jikan

class FavoriteViewControllerTests: XCTestCase {
    
    var sut: FavoriteViewController!
    let fakeAnimes = [
        Anime(mal_id: 5114, image_url: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg?s=faffcb677a5eacd17bf761edd78bfb3f", url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", title: "Fullmetal Alchemist: Brotherhood", rank: 1, start_date: "Apr 2009", end_date: "Jul 2010", type: "TV"),
        Anime(mal_id: 40028, image_url: "https://cdn.myanimelist.net/images/anime/1000/110531.jpg?s=3df5ebb6800604dc04c6a6187dd7161b", url: "https://myanimelist.net/anime/40028/Shingeki_no_Kyojin__The_Final_Season", title: "Shingeki no Kyojin: The Final Season", rank: 2, start_date: "Dec 2020", end_date: nil, type: "TV"),
        Anime(mal_id: 9253, image_url: "https://cdn.myanimelist.net/images/anime/5/73199.jpg?s=97b97d568f25a02cf5a22dda13b5371f", url: "https://myanimelist.net/anime/9253/Steins_Gate", title: "Steins;Gate", rank: 3, start_date: "Apr 2011", end_date: "Sep 2011", type: "TV")
    ]
    
    override func setUpWithError() throws {
        AnimeDocument.cleanLocalAnimes()
        prepareFakeFavoriteAnimes()
        
        sut = FavoriteViewController()
    }

    override func tearDownWithError() throws {
        AnimeDocument.cleanLocalAnimes()
        sut = nil
    }
    
    private func prepareFakeFavoriteAnimes() {
        fakeAnimes.forEach() {
            let document = AnimeDocument(anime: $0)
            document?.save()
        }
    }
}

extension FavoriteViewControllerTests {
    func testFetchFavoriteAnimes() {
        sut.viewModel.fetchLocalAnimes()
        XCTAssert((sut.tableView.animes == fakeAnimes), "Fetch favorite animes fail")
    }
    
    func testRemoveAnimeFromFavorite() {
        sut.viewModel.fetchLocalAnimes()
        var originalAnimes = sut.tableView.animes
        
        if let cell =  sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AnimeTableViewCell {
            sut.tableView.didActionButtonTapped(in: cell)
            
            originalAnimes.removeFirst()
            XCTAssert((sut.tableView.animes == originalAnimes), "Remove anime from favorite fail")

        }
    }
}
