//
//  InitialViewController.swift
//  BTC Conversion
//
//  Created by Hardik Makwana on 22/01/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class InitialViewController: UIViewController {

    // MARK: - Members
    @IBOutlet weak var userNameTxt: UITextField!
    
    // MARK: - View-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = true
    }
    
    // MARK: - IBAction
    @IBAction func startButtonAction(_ sender: Any) {
        
        if userNameTxt.text?.count == 0{
            objAppManager.showAlertWith(title: NSLocalizedString("Name Required", comment: ""), message: NSLocalizedString("Please enter name to continue", comment: ""), InViewController: self)
        }else{
            UserDefaults.standard.set(self.userNameTxt.text, forKey: "User_Name")
            UserDefaults.standard.synchronize()
            objAppManager.navigateToViewController = NavigateTo.CurrencySelectionVC
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}
