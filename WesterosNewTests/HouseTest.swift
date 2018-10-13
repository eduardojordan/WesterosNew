//
//  HouseTest.swift
//  WesterosNewTests
//
//  Created by Eduardo on 7/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import XCTest
@testable import WesterosNew



class HouseTest: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        
        robb = Person(name: "Robb", alias: "El joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   // 1erTest comprobamos que la casa Existe
    
    func testHouseExistence(){
        
//        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
//
//        let stark = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        
        XCTAssertNotNil(starkHouse)
    }
    
    // 2doTest Comprobamos que exista un Sigil
    
    func testSigilExistence(){
     //   let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
            
        XCTAssertNotNil(starkSigil)
        
   //      let lannisterSigil = Sigil(description: "Leon Rampante", image: UIImage())
        
        XCTAssertNotNil(lannisterSigil)
    }
    
      func testHouse_AddPersons_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        
        XCTAssertEqual(starkHouse.count, 1)
        
        
        starkHouse.add(person: arya)
         XCTAssertEqual(starkHouse.count, 2)
        
         XCTAssertEqual(lannisterHouse.count, 0)
        lannisterHouse.add(person: tyrion)
        
        //starkHouse.add(person: tyrion)
        XCTAssertEqual(lannisterHouse.count, 1)
       
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
        
    }
    func testHouseEquality() {
        // 1. Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // 2. Igualdad
         let jinxedUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Starko")!
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: jinxedUrl)
        XCTAssertEqual(jinxed, starkHouse)
        
        // 3. Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseHashable(){
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison(){
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }

}
