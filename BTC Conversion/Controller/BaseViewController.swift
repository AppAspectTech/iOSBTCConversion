//
//  BaseViewController.swift
//  BTC Conversion
//
//  Created by Hardik Makwana on 22/01/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Members
    var objInitialVC:InitialViewController?
    var objCurrencySelectionVC:CurrencySelectionViewController?
    
    // MARK: - View-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        // Checking User Open app first time
        // check here blank "User_Name"
        if (UserDefaults.standard.value(forKey: "User_Name") == nil) {
            objAppManager.navigateToViewController = NavigateTo.InitialVC
        }else{
            objAppManager.navigateToViewController = NavigateTo.CurrencySelectionVC
        }
        
        // Change ViewController when app gone in the background
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewControllerViaNotificationCenter), name: NSNotification.Name(rawValue: "changeViewController"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.manageViewControllerStack()
    }
    
    // MARK: - Selectors
    @objc func changeViewControllerViaNotificationCenter() {
        if (UserDefaults.standard.value(forKey: "User_Name") != nil) {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    // MARK: - Change ViewController - Manager ViewController Navigation
    func manageViewControllerStack() {
        
        switch objAppManager.navigateToViewController{
        case .InitialVC:
            if objInitialVC == nil{
                objInitialVC = storyboard!.instantiateViewController(withIdentifier: "InitialViewController") as? InitialViewController
            }
            navigationController?.pushViewController(objInitialVC!, animated: false)
            break
        case .CurrencySelectionVC:
            
            if objCurrencySelectionVC == nil{
                objCurrencySelectionVC = storyboard!.instantiateViewController(withIdentifier: "CurrencySelectionViewController") as? CurrencySelectionViewController
            }
            navigationController?.pushViewController(objCurrencySelectionVC!, animated: false)
            break
            
        }
    }
}
