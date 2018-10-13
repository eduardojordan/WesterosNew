//
//  AppDelegate.swift
//  WesterosNew
//
//  Created by Eduardo on 7/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var splitViewController: UISplitViewController!
    var seasonDetailViewController: SeasonDetailViewController!
    var houseDetailViewController: HouseDetailViewController!
    var houseListNavigation: UINavigationController!
    var seasonListNavigation: UINavigationController!
    
    var houseDetailNavigation: UINavigationController!
    var seasonDetailNavigation: UINavigationController!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        //Creamos el modelo
        
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        //Creamos los controladores
        
        let houseListViewController = HouseListViewController(model: houses)
        let lastHouseSelected = houseListViewController.lastSelectHouse()
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let seasonListViewController = SeasonListViewController(model:seasons)
        let lastSeasonSelected = seasonListViewController.lastSelectSeason()
        seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        
        // Asignamos delegados
        if UIDevice.current.userInterfaceIdiom == .pad {
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        } else {
        houseListViewController.delegate = houseListViewController
        seasonListViewController.delegate = seasonListViewController
            }
        
        // Creamos los navigation
        houseListNavigation = houseListViewController.wrappedInNavigation()
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        
        
        
        // Creaamos el TabBar
        
        //OPErATIVO
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [ houseListNavigation , seasonListNavigation]
        
        tabBarController.delegate = self
        tabBarController.tabBar.backgroundColor = UIColor.brown
        
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [tabBarController, houseDetailNavigation, seasonDetailNavigation]
        
        
        
        tabBarController.title = "Westeros"
        
//        [houseDetailViewController, seasonDetailViewController].forEach {
//            $0.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
//        }

        
        
        // Asignamos el rootVC
        window?.rootViewController = splitViewController
        
        return true
    }
    
}


extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // iPad only
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            if let navController = viewController as? UINavigationController {
                let typeOfController = type(of: navController.viewControllers.first!)
                var detailController: UINavigationController
               
                
                switch (typeOfController) {
                case is HouseListViewController.Type:
                    detailController = houseDetailNavigation
                    
                case is SeasonListViewController.Type:
                    detailController = seasonDetailNavigation
                    
                default:
                    NSLog("Unknown controller \(typeOfController)")
                    detailController = UINavigationController()
                }
                
                splitViewController.showDetailViewController(detailController, sender: self)
            }
        }
    }
}


    
