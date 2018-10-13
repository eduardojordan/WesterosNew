//
//  Repository.swift
//  WesterosNew
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}
//Procolo House factory
protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy filter: Filter) -> [House]
}
// Protocolo Season Factoru
protocol SeasonFactory {
    typealias FilterSeason = (Season) -> Bool
    
    var seasons: [Season] { get }
    func season(named: String) -> Season?
    func seasons(filteredBy: FilterSeason) -> [Season]
}

final class LocalFactory: HouseFactory, SeasonFactory {
    
    var houses: [House] {
        
        //House REPO
        
        // Houses creation here
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "Leon Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragon tricefalo")

        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: targaryenUrl)
        
        // Characters creation
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, jaime, cersei)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    // Filter House
    func house(named: String) -> House? {
        return houses.first { $0.name.uppercased() == named.uppercased() }
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
    
    
     // Filter Season
    func season(named: String) -> Season? {
        return seasons.first { $0.name.uppercased() == named.uppercased() }
    }

    func seasons(filteredBy: FilterSeason) -> [Season] {
        return seasons.filter(filteredBy)

    }
    
    // Mark: Season REPO
    
    //Season Created
    
      var seasons: [Season] {
        
        let season1 = Season(name: "Season 1", releaseDate: "2011-04-17")
        let season2 = Season(name: "Season 2", releaseDate: "2012-04-01")
        let season3 = Season(name: "Season 3", releaseDate: "2013-03-31")
        let season4 = Season(name: "Season 4", releaseDate: "2014-04-06")
        let season5 = Season(name: "Season 5", releaseDate: "2015-04-12")
        let season6 = Season(name: "Season 6", releaseDate: "2016-04-24")
        let season7 = Season(name: "Season 7", releaseDate: "2017-07-16")
        
        
        //Episode Creation
        
        //Episodes Season 1
        let episode1Season1 = Episode(title: "Se acerca el invierno", dateRelease: "2011-04-01", season: season1)
        let episode2Season1 = Episode(title: "El Camino Real", dateRelease: "2011-04.24", season: season1)
        
        season1.add(episodes: episode1Season1,episode2Season1)
        
        //Episodes Season 2
        let episode1Season2 = Episode(title: "El Norte no olvida", dateRelease: "2012-04-01", season: season2)
        let episode2Season2 = Episode(title: "Las tierras de la noche", dateRelease: "2011-04-08", season: season2)
        
        season2.add(episodes: episode1Season2,episode2Season2)
        
        //Episodes Season 3
        let episode1Season3 = Episode(title: "Valar Dohaeris", dateRelease: "2013-03-31", season: season3)
        let episode2Season3 = Episode(title: "Alas negras, palabras negras", dateRelease: "2013-04-07", season: season3)
        
        season3.add ( episodes: episode1Season3,episode2Season3)
        
        //Episodes Season 4
        let episode1Season4 = Episode(title: "Dos espadas", dateRelease: "2014-04-06", season: season4)
        let episode2Season4 = Episode(title: "El león y la rosa", dateRelease: "2014-04-13", season: season4)
        
        season3.add(episodes: episode1Season4, episode2Season4)
        
        //Episodes Season 5
        let episode1Season5 = Episode(title: "Las guerras venideras", dateRelease: "2015-04-12", season: season5)
        let episode2Season5 = Episode(title: "La Casa de Negro y Blanco", dateRelease: "2015-04-19", season: season5)
        
        season5.add(episodes: episode1Season5, episode2Season5 )
        
        //Episodes Season 6
        let episode1Season6 = Episode(title: "La mujer roja", dateRelease: "2016-03-01", season: season6)
        let episode2Season6 = Episode(title: "A casa", dateRelease: "2016-03-08", season: season6)
        
        season6.add(episodes: episode1Season6, episode2Season6 )
        
        //Episodes Season 7
        let episode1Season7 = Episode(title: "Rocadragón", dateRelease: "2017-06-16", season: season7)
        let episode2Season7 = Episode(title: "Nacido de la tormenta", dateRelease: "2017-06-23", season: season7)
        
        season7.add(episodes: episode1Season7, episode2Season7 )
        
        return [season1,season2,season3,season4,season5,season6,season7]
        
  
        
        
    }
    
}

