//
//  EpisodeTest.swift
//  WesterosNewTests
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import XCTest
@testable import WesterosNew

class EpisodeTest: XCTestCase {
    
    var season1: Season!
    
    var episode1Season1: Episode!
    var episode2Season1: Episode!
    
    

    override func setUp() {
        season1 = Season(name: "Season 1", releaseDate: "2011-04-17")
        
        episode1Season1 = Episode(title: "Se acerca el invierno", dateRelease: "2011-04-01", season: season1)
        episode2Season1 = Episode(title: "El Camino Real", dateRelease: "2011-04.24", season: season1)
    }

    override func tearDown() {
        
    }

    //Existence
    func testEpisodeExistence(){
        XCTAssertNotNil(episode2Season1)
       
    }
    
    //Equality
    func testEpisodeEquality(){
    // Identidad
        XCTAssertEqual(episode2Season1, episode2Season1)
    //Igualdad
        let episodeX = Episode(title: "Se acerca el invierno", dateRelease: "2011-04-01", season: season1)
        XCTAssertEqual(episode1Season1, episodeX )
    //desigualdad
        XCTAssertNotEqual(episode1Season1, episode2Season1)
        
    }

}
