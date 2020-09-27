//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 17/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    var convertExchangeModel = ConvertExchangeModel()
    
    
    @IBOutlet weak var euroTxtField: UITextField!
    
    @IBOutlet weak var dollarResultLabel: UILabel!
    
    @IBAction func tappedArrowConversionButton() {
       
            ExchangeServiceModel.shared.createConversionRequestTask { Result in
                switch Result {
                case .success : self.update()
                case .failure : self.presentAlert(message:"error")
                }
            }
        }
    
    func update() {
        let result = convertExchangeModel.convert()
        DispatchQueue.main.sync {
            convertExchangeModel.euroTxtField = euroTxtField.text!
            dollarResultLabel.text = result
        }
    }
    
    
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
}


/* ExchangeServiceModel.shared.createConversionRequestTask { (success) in
 DispatchQueue.main.async {
 if success, let exchangeData = exchangeData {
 self.update(exchangeData: exchangeData)
 } else {
 self.presentAlert()
 }
 }
 } */

