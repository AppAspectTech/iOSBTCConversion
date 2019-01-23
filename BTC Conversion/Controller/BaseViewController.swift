//
//  BaseViewController.swift
//  BTC Conversion
//
//  Created by Hardik Makwana on 22/01/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var objInitialVC:InitialViewController?
    var objCurrencySelectionVC:CurrencySelectionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        // Checking User Open app first time
        
        //let userName:String = (UserDefaults.standard.value(forKey: "User_Name") as! String)
        
        if (UserDefaults.standard.value(forKey: "User_Name") == nil) {
            objAppManager.navigateToViewController = NavigateTo.InitialVC
        }else{
            objAppManager.navigateToViewController = NavigateTo.CurrencySelectionVC
        }
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewControllerViaNotificationCenter), name: NSNotification.Name(rawValue: "changeViewController"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.changeViewController()
    }
    @objc func changeViewControllerViaNotificationCenter() {
        if (UserDefaults.standard.value(forKey: "User_Name") != nil) {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    // MARK: - Change ViewController - Manager ViewController Navigation
    func changeViewController() {
        
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
//        default:
//            if objInitialVC == nil{
//                objInitialVC = storyboard!.instantiateViewController(withIdentifier: "InitialViewController") as? InitialViewController
//            }
//            navigationController?.pushViewController(objInitialVC!, animated: false)
//            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
