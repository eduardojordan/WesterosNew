//
//  RepositoryTest.swift
//  WesterosNewTests
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import XCTest
@testable import WesterosNew

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    
    override func setUp() {
        localHouses = Repository.local.houses
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "sTaRk")
        
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        //        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        var filtered = Repository.local.houses { $0.count == 1 }
        XCTAssertEqual(filtered.count, 1)
        
        filtered = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
    }
}
