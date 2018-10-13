//
//  SeasonTest.swift
//  WesterosNewTests
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import XCTest
@testable import WesterosNew


class SeasonTest: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    var episode1Season1: Episode!
    

    override func setUp() {
        season1 = Season(name: "Season 1", releaseDate: "2011-04-17")
        season2 = Season(name: "Season2", releaseDate: "2012-04-01")
        
        episode1Season1 = Episode(title: "Se acerca el invierno", dateRelease: "2011-04-24", season: season1)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   //Existencia
    func testSeasonExistence(){
        XCTAssertNotNil(season1)
    }
    
    //Add Episode Correct
    func testSeasonAddEpisodeCorrect(){
        XCTAssertEqual(season1.count, 0)
        season1.add(episode:episode1Season1)
        
        XCTAssertNotEqual(season1.count, 1)
        
    }
    

    //Test Igualdad
    func testSeasonEquality(){
        
        //Identidad
        XCTAssertEqual(season1, season1)
        
        //Igualdad
        let seasonX = Season(name: "Season 1", releaseDate: "2011-04-17")
        XCTAssertEqual(season1, seasonX)
       
        //Desigualdad
        XCTAssertNotEqual(season1, season2)
        
    }
    
    func testSeasonHashable(){
        XCTAssertNotNil(season1.hashValue)
    }
  
    
    func testSeasonComparison(){
        XCTAssertLessThan(season1, season2)
    }
    
}
