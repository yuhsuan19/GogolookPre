//
//  TypePickerViewControllerTests.swift
//  JikanTests
//
//  Created by CHI on 2021/2/1.
//

import XCTest
@testable import Jikan

class TypePickerViewControllerTests: XCTestCase {
    
    var sut: TypePickerViewController!
    
    override func setUpWithError() throws {
        sut = TypePickerViewController(selectedType: .anime, selectedSubType: .airing)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
}

extension TypePickerViewControllerTests {
    func testSelectType() {
        if let mangaIndex = sut.types.firstIndex(of: .manga) {
            sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: mangaIndex, section: 0))
            XCTAssert((sut.selectedType == .manga), "Select type fail")
            XCTAssert((sut.selectedSubType == nil), "Select type fail")
        }
        
        if let animeIndex = sut.types.firstIndex(of: .anime) {
            sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: animeIndex, section: 0))
            XCTAssert((sut.selectedType == .anime), "Select type fail")
            XCTAssert((sut.selectedSubType == nil), "Select type fail")
        }
    }
    
    func testSelecteSubType() {
        if let tvIndex = sut.subtypes[sut.selectedType]?.firstIndex(of: .tv) {
            sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: tvIndex, section: 1))
            XCTAssert((sut.selectedSubType == .tv), "Select subtype fail")
        }
    }
    
    func testDeselectSubType() {
        if let airingIndex = sut.subtypes[sut.selectedType]?.firstIndex(of: .airing) {
            sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: airingIndex, section: 1))
            XCTAssert((sut.selectedSubType == nil), "Deselect subtype fail")
        }
    }
}
