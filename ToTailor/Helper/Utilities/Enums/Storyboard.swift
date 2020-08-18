//
//  Storyboard.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case registration   = "Registration"
    case main           = "Main"
    case home           = "Home"
    
    enum Main: String {
        case TabBarController        
        
        var instance: UIViewController {
            return UIStoryboard(name: Storyboard.main.rawValue, bundle: mainBundle).instantiateViewController(withIdentifier: self.rawValue)
        }
    }
}


// MARK: Registration
extension Storyboard {
    enum Registration: String {
        case RegisterViewController
        case LoginViewController
        
        var instance: UIViewController {
            return UIStoryboard(name: Storyboard.registration.rawValue, bundle: mainBundle).instantiateViewController(withIdentifier: self.rawValue)
        }
    }
}
