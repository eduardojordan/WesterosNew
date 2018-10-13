//
//  House.swift
//  WesterosNew
//
//  Created by Eduardo on 7/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit


typealias Words = String
typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members = Members()
     
    init(name: String, sigil: Sigil, words:Words, url:URL){
    self.name = name
    self.sigil = sigil
    self.words = words
        self.wikiURL = url
    self._members = Members()
        
  }
}

extension House {
    var count: Int{
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add (person:Person){
        guard self == person.house else {
            return
        }
           _members.insert(person)
    }
    func add(persons: Person...) {
        persons.forEach { add(person: $0) }
    }
}

extension House{
    var proxyForEquality: String {
        return "\(name)\(words)\(count)"
    }

var proxyForComparison: String{
    return name.uppercased()
    }
}
extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        // Orden alfabetico
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

