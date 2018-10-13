//
//  Characters.swift
//  WesterosNew
//
//  Created by Eduardo on 7/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import Foundation


final class Person {
    
    // Mark : Properties
    let name : String
    let house : House
    // las propiedades privadas suelen comenzar con barra baja// propiedad computada
  private  let _alias : String?
    
    var alias: String{
//        get{
//            if let alias = _alias{
//                //Existe y esta guardado dentro de alias
//                return alias
//            }else{
//                return ""
//            }
//        }
//    }
        get{
        return _alias ?? "" // devuelve _alias, si hay algo, si no no!
        }
    }
    
    // Mark : Initialization
    // Este ejemplo es de 2 designados
    init(name: String, alias: String? = nil, house: House){
        self.name = name
        self.house = house
        self._alias = alias
    }
}
//   convenience init (name:String, house: House){
////    self.name = name
////    self.house = house
////    _alias = nil
//
//    // Asi podemos usar el init de conveniencia
//    self.init(name: name, alias:nil ,house: house)
//    }
    
    
extension Person {
        var fullName: String{
            return "\(name) \(house.name)"
        }

}

extension Person{
    var proxy: String{
        return "\(name)\(alias)\(house.name)"
    }
    
    var proxyForComparison: String {
        return "\(fullName)"
    }
    
}


extension Person: Hashable {
    var hashValue: Int{
        return proxy.hashValue
    }
    
}

extension Person : Equatable{
    static func == (lhs: Person, rhs: Person) -> Bool{
        return lhs.proxy == rhs.proxy
    }
}
    
extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
        }
        
    
}



