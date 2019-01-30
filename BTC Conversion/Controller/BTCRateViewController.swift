//
//  BTCRateViewController.swift
//  BTC Conversion
//
//  Created by Hardik Makwana on 22/01/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class BTCRateViewController: UIViewController {

    // MARK: - Members
    @IBOutlet weak var rateTableView: UITableView!
    
    var selectedCurrencyArray:NSArray!
    var tickerDataArray:NSMutableArray! = NSMutableArray()
  
    // MARK: - View-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rateTableView.delegate = self
        self.rateTableView.dataSource = self
        self.rateTableView.tableFooterView = UIView()
        self.rateTableView.register(UINib(nibName: "RateCell", bundle: nil), forCellReuseIdentifier: "RateCell")
        self.rateTableView.separatorStyle = .none
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setBackgroundColor(themeColor)
        SVProgressHUD.setForegroundColor(UIColor.white)
        
        self.getCurrencyTickerData(showHUD: true)
       
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getCurrencyTickerData(showHUD:)), object: nil)
    }
    // MARK: - IBAction
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Selector
    @objc func getCurrencyTickerData(showHUD:Bool){
      
        if showHUD {
            SVProgressHUD.show()
        }
        self.tickerDataArray.removeAllObjects()
        for name in  self.selectedCurrencyArray{
           //let name = self.selectedCurrencyArray[index] as! String
        
            let URL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC\(name)"
            Alamofire.request(URL,
                              method: .get,
                              parameters: nil)
                .validate()
                .responseJSON { response in
                    guard response.result.isSuccess else {
                        
                        return
                    }
                    let dic = response.value as! NSDictionary
                    print(dic)
                    self.tickerDataArray.add(dic)
                    
                    if self.tickerDataArray.count == self.selectedCurrencyArray.count
                    {
                        DispatchQueue.main.async(execute: {
                            SVProgressHUD.dismiss()
                            self.rateTableView.reloadData()
                            self.perform(#selector(self.getCurrencyTickerData(showHUD:)), with: nil, afterDelay: 20)
                            
                        })
                    }
            }
        }
    }
}
// MARK: - UITableView
extension BTCRateViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tickerDataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateCell", for: indexPath) as! RateCell
        cell.backgroundColor = UIColor.clear
        cell.accessoryType = .none
        cell.selectionStyle = .none
        
        let dicDetails = self.tickerDataArray[indexPath.row] as! NSDictionary
        print(dicDetails)
        cell.currencyNameLabel.text = String((dicDetails.value(forKey: "display_symbol") as! String).suffix(3))
        cell.lastPriceLabel.text = "\(Float(truncating: dicDetails.value(forKey: "last") as! NSNumber))"
        cell.currencySymbolLabel.text = currencySymbols.value(forKey: cell.currencyNameLabel.text!) as? String
        
        var changePrice:Float = 0.0
        if(((dicDetails.value(forKey: "changes") as! NSDictionary).value(forKey: "price") as! NSDictionary).value(forKey: "hour") != nil){
            changePrice = Float(truncating: ((dicDetails.value(forKey: "changes") as! NSDictionary).value(forKey: "price") as! NSDictionary).value(forKey: "hour") as! NSNumber)
        }
        
        var changePercent:Float = 0.0
        if ((dicDetails.value(forKey: "changes") as! NSDictionary).value(forKey: "percent") as! NSDictionary).value(forKey: "hour") != nil {
            changePercent = Float(truncating: ((dicDetails.value(forKey: "changes") as! NSDictionary).value(forKey: "percent") as! NSDictionary).value(forKey: "hour") as! NSNumber)
        }
        if changePrice < 0 {
            cell.diffrerenceLabel.text = "\(cell.currencySymbolLabel.text ?? "") \(changePrice) (\(changePercent)%)"
            cell.diffrerenceLabel.textColor = redThemeColor
        }else{
            cell.diffrerenceLabel.text = "\(cell.currencySymbolLabel.text ?? "") +\(changePrice) (\(changePercent)%)"
            cell.diffrerenceLabel.textColor = greenThemeColor
        }
        return cell
    }
}
