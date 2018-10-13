//
//  Episode.swift
//  WesterosNew
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import Foundation

final class Episode {
    
    // Mark: - Properties
    
    let title: String
    let dateRelease : Date
    weak var season : Season?
    
    
    init(title: String, dateRelease: String, season: Season){
        self.title = title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.dateRelease = formatter.date(from: dateRelease)!
        self.season = season
        
    }
}

// Mark: Protocols

extension Episode{
    var proxyForEqual: String {
        return "\(title)\(dateRelease)\(season?.name ?? "")"
    }
    
    var proxyForCompare: Date {
        return dateRelease
    }
    
}


// Mark : Equatable
extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEqual == rhs.proxyForEqual
    }
    
}
// Mark : Hashable
extension Episode : Hashable {
    var hashValue: Int{
        return proxyForEqual.hashValue
    }
 
}
// Mark : Comparable
extension Episode: Comparable{
    static func < (lhs: Episode, rhs: Episode) -> Bool{
        //Orden Alfabetico
        return lhs.proxyForCompare < rhs.proxyForCompare
    }
}
// Mark : CustomStringConvertible
extension Episode: CustomStringConvertible{
    var description : String{
        return "\(title)"
    }
}
