//
//  Season.swift
//  WesterosNew
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>


final class Season {
    
    let name: String
    private var  _episodes: Episodes
    let releaseDate: Date
    
    init(name: String, episodes: Episodes = Episodes(), releaseDate: String){
        self.name = name
        _episodes = episodes
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.releaseDate = formatter.date(from: releaseDate)!
        
    }
    
}
extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    
    func add(episode: Episode) {
        guard episode.season == self else { return }
        _episodes.insert(episode)
    }
    
    
    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }
}

// Mark : - Protocols

extension Season{
    var proxyForEqual: String {
        return "\(name)\(count)\(releaseDate)"
    }
    var proxyForCompare: Date{
        return releaseDate
    }
}


// Mark : Hashable
extension Season : Hashable {
    var hashValue: Int{
        return proxyForEqual.hashValue
    }
    
    
}
// Mark : Equatable
extension Season: Equatable{
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEqual == rhs.proxyForEqual
    }
    
}
// Mark : Comparable
extension Season: Comparable{
    static func < (lhs: Season, rhs: Season) -> Bool {
        // Orden alfabetico
        return lhs.proxyForCompare < rhs.proxyForCompare
    }
    
}

// Mark : CustomStringConvertible
extension Season: CustomStringConvertible{
    var description: String {
        return "\(name)"
    }
    
    
    
    
}

