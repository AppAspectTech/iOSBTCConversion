//
//  AppManager.swift
//  BTC Conversion
//
//  Created by Hardik Makwana on 22/01/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit

// Navigation Enum
enum NavigateTo : Int {
    case InitialVC = 0
    case CurrencySelectionVC
    
}

let objAppManager = AppManager.sharedInstance

class AppManager: NSObject {

    var navigateToViewController = NavigateTo.InitialVC
    static let sharedInstance = AppManager()
    
    
    func showAlertWith(title:String, message:String, InViewController currentVC: UIViewController) -> Void {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(action1)
        currentVC.present(alertController, animated: true, completion: nil)
    }
    
}


