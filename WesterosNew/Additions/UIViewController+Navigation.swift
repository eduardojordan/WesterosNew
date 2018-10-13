//
//  UIViewController+Navigation.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        // return UINavigationController(rootViewController: self)
        
         navigation.navigationBar.backgroundColor = UIColor.brown
        
        return navigation
    }
}
