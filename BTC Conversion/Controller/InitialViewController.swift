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

    
    @IBOutlet weak var userNameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startButtonAction(_ sender: Any) {
        
        if userNameTxt.text?.count == 0{
            objAppManager.showAlertWith(title: "Name Required", msg: "Please enter name to continue", viewController: self)
        }else{
            UserDefaults.standard.set(self.userNameTxt.text, forKey: "User_Name")
            UserDefaults.standard.synchronize()
            objAppManager.navigateToViewController = NavigateTo.CurrencySelectionVC
            self.navigationController?.popToRootViewController(animated: false)
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
