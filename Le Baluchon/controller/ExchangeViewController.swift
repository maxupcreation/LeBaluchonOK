//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 17/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    var exchangeService = ExchangeServiceModel()
    
    @IBOutlet weak var euroTxtField: UITextField!
    
    @IBOutlet weak var dollarResultLabel: UILabel!
    
    @IBAction func tappedArrowConversionButton() {
        exchangeService.createConversionRequestTask { (success,data) in
            DispatchQueue.main.async {
                if success, let exchangeData = exchangeData {
                    self.update(exchangeData: exchangeData)
                } else {
                    self.presentAlert()
                }
            }
        }
    }
    
    

    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
