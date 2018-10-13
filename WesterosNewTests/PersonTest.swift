//
//  CharacterTest.swift
//  WesterosNewTests
//
//  Created by Eduardo on 7/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import XCTest
@testable import WesterosNew



class PersonTest: XCTestCase {
    
    var starkHouse: House!
    var starkSigil: Sigil!
    var ned : Person!
    var arya : Person!

    override func setUp() {
        
        // Este metodo siempre se usa antes, para tener siempre el mismo estado, y el test es independiente del anterior
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterExistence(){
        
        XCTAssertNotNil(ned)
        
        XCTAssertNotNil(arya)
        
    }
    
    func testPersonFullName(){
        
        XCTAssertEqual(ned.fullName, "Eddard Stark")
        XCTAssertEqual(arya.fullName, "Arya Stark")
    }
    func testPersonEquality(){
        //.Identidad
        XCTAssertEqual(ned, ned)
        //Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(eddard, ned)
        // Desigualdad
        XCTAssertNotEqual(ned, arya)
    }
}
