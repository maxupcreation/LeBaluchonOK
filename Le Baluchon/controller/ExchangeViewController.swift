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
    
    var exchangesServiceModel = ExchangeServiceAPI()
    
    
    @IBOutlet weak var euroTxtField: UITextField!
    
    @IBOutlet weak var dollarResultLabel: UILabel!
    
    @IBAction func tappedArrowConversionButton() {
        
        exchangesServiceModel.createConversionRequestTask() { result in
            switch result {
                
            case .success(let data) :
                self.update(data: data)
                
            case .failure : self.presentAlert(message:"error")
                
            }
        }
    }
    
    func update(data : ExchangeData) {
        DispatchQueue.main.sync {
            let result = convert(value: euroTxtField.text ?? "", rates: data)
            dollarResultLabel.text = result
        }
    }
    
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func convert(value: String, rates: ExchangeData) -> String  {
        guard let rate = rates.rates["USD"] else { return "NA" }
        guard let valueDoubled = Double(value) else {return "NA"}
        return String(valueDoubled / rate)
    }
    
    
}

