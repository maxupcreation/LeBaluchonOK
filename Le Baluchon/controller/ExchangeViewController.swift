//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 17/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    //MARK: - VARIABLE
    
    @IBOutlet weak var euroTxtField: UITextField!
    
    @IBOutlet weak var dollarResultLabel: UILabel!
   
    // Model instance
    var exchangesServiceModel = ExchangeServiceAPI()
    
    //MARK: - BUTTON ACTION UPDATE
    
    @IBAction func tappedArrowConversionButton() {
        
        // Start of request, if success udpate view, if not else failure alert
        exchangesServiceModel.createConversionRequestTask() { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data) :
                    self.update(data: data)
                    
                case .failure : self.presentAlert(message:"error")
                    
                }
            }
        }
    }
    
    func update(data : ExchangeData) {
        
        let result = self.convert(value: self.euroTxtField.text ?? "", rates: data)
        self.dollarResultLabel.text = result
    }
    
    func convert(value: String, rates: ExchangeData) -> String  {
        guard let rate = rates.rates["USD"] else { return "NA" }
        guard let valueDoubled = Double(value) else {return "NA"}
        return String(format:"%.2f",valueDoubled / rate)
    }
    
    //MARK: - ALERT
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
