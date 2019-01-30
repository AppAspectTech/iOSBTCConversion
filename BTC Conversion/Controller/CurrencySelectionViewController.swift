//
//  CurrencySelectionViewController.swift
//  BTC Conversion
//
//  Created by Hardik Makwana on 22/01/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit

class CurrencySelectionViewController: UIViewController {

    // MARK: - Members
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCurrencyArray:NSMutableArray! = NSMutableArray()
    var objBTCRateVC:BTCRateViewController?
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // MARK: - View-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameLabel.text = "Hello \(UserDefaults.standard.value(forKey: "User_Name")!)"
        
        self.collectionView.register(UINib(nibName: "CurrencyCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCollectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedCurrencyArray.removeAllObjects()
        self.collectionView.reloadData()
    }
    // MARK: - IBAction
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if self.selectedCurrencyArray.count == 0{
            objAppManager.showAlertWith(title: NSLocalizedString("Select Currency", comment: ""), message: NSLocalizedString("Please selecte minimum 1 currency", comment: ""), InViewController: self)
        }else{
            if objBTCRateVC == nil{
                objBTCRateVC = storyboard!.instantiateViewController(withIdentifier: "BTCRateViewController") as? BTCRateViewController
            }
            objBTCRateVC!.selectedCurrencyArray = self.selectedCurrencyArray
            navigationController?.pushViewController(objBTCRateVC!, animated: true)
        }
        
    }
}

// MARK: - UICollectionView
extension CurrencySelectionViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyArray.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenWidth - 45) / 3, height: 70)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CurrencyCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionCell", for: indexPath) as! CurrencyCollectionCell
        cell.currencyLabel.text = currencyArray[indexPath.row]
        
        if self.selectedCurrencyArray.contains(cell.currencyLabel.text!){
            cell.containerView.backgroundColor = themeColor
            cell.currencyLabel.textColor = UIColor.white
        }else{
            cell.containerView.backgroundColor = UIColor.white
            cell.currencyLabel.textColor = blackThemeColor
        }
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let currency = currencyArray[indexPath.row]
            if self.selectedCurrencyArray.contains(currency){
                self.selectedCurrencyArray.remove(currency)
            }else{
                if self.selectedCurrencyArray.count < 4{
                    self.selectedCurrencyArray.add(currency)
                }
            }
            self.collectionView.reloadItems(at: [indexPath])
    }
}
