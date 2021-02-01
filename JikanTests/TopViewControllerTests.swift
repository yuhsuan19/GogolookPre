//
//  TopViewControllerTest.swift
//  JikanTests
//
//  Created by CHI on 2021/2/1.
//

import XCTest
@testable import Jikan

class TopViewControllerTests: XCTestCase {
    
    var sut: TopViewController!
    
    override func setUpWithError() throws {
        AnimeDocument.cleanLocalAnimes()
        sut = TopViewController()
    }

    override func tearDownWithError() throws {
        AnimeDocument.cleanLocalAnimes()
        sut = nil
    }
}

extension TopViewControllerTests {
    func testFetchTopAnimnes() {
        let originAnimesCount = sut.tableView.animes.count
        
        let promise = XCTestExpectation()
        sut.viewModel.fetchTopAnimes {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
        
        XCTAssert((sut.tableView.animes.count == originAnimesCount + 50), "Fetch top animes fail")
    }
    
    func testLoadMore() {
        let originalPage = sut.viewModel.page
        
        sut.loadMoreContent()
        
        XCTAssert((sut.viewModel.page == originalPage + 1), "Set fetching animes page fail")
    }
    
    func testDidAnimeTypePicked() {
        sut.didAnimeTypePicked(type: .manga, subType: .manhua)
        
        XCTAssert((sut.viewModel.type == .manga), "Reset type fail")
        XCTAssert((sut.viewModel.subType == .manhua), "Reset subtype fail")
        XCTAssert((sut.viewModel.page == 1), "Reset page fail")
        XCTAssert((sut.viewModel.isLoadAll == false), "Reset isLoadAll flag fail")
        XCTAssert((sut.tableView.animes.isEmpty), "Clean animes fail")
    }
    
    func testUpdateFavoriteAnimes() {
        let promise = XCTestExpectation()
        sut.viewModel.fetchTopAnimes {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
        
        if let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AnimeTableViewCell {
            sut.tableView.didActionButtonTapped(in: cell)
            XCTAssert((sut.tableView.animes[0].isFavorite == true), "Add favorite anime fail")
            sut.tableView.reloadData()
            
            if let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AnimeTableViewCell {
                sut.tableView.didActionButtonTapped(in: cell)
                XCTAssert((sut.tableView.animes[0].isFavorite == false), "Update favorite anime fail")
            }
        } else {
            XCTAssert(false)
        }
    }
}

