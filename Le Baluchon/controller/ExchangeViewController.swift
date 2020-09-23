//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 17/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {

    let exchangeService = ExchangeServiceModel()
    
    @IBOutlet weak var euroTxtField: UITextField!

    @IBOutlet weak var dollarResultLabel: UILabel!
    
    @IBAction func tappedArrowConversionButton(_ sender: Any) {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeService.createConversionRequestTask { result in
            switch result {
            case .success(let exchangeData) :
                print(exchangeData.rates["USD"])
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
