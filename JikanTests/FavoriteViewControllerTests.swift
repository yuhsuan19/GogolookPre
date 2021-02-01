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
    
    override func setUpWithError() throws {
        sut = FavoriteViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
}
