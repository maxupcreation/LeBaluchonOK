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
    
    @IBOutlet weak var ButtonOutLet: UIButton!
    @IBOutlet weak var dollarResultLabel: UILabel!
    
    // Model instance
    var exchangesServiceModel = ExchangeServiceAPI()
    
    //MARK: - BUTTON ACTION & UPDATE
    
    @IBAction func tappedArrowConversionButton() {
        
        animateTappedButton()
        
        // Start of request, if success udpate view, if not else failure alert
        exchangesServiceModel.createConversionRequestTask() { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data) :
                    self.update(data: data)
                    self.successChangeColorAnimate()
                    
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
    
    //MARK: - COLOR & ANIMATE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ButtonOutLet.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.euroTxtField.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        self.euroTxtField.layer.cornerRadius = 50
        self.euroTxtField.layer.masksToBounds = true
        
        self.dollarResultLabel.backgroundColor = #colorLiteral(red: 0.4864498352, green: 0.8406358007, blue: 0, alpha: 1)
        self.dollarResultLabel.layer.cornerRadius = 50
        self.dollarResultLabel.layer.masksToBounds = true
    }
    
    
    func successChangeColorAnimate(){
        UIView.animate(withDuration: 0.5) {
            self.ButtonOutLet.tintColor = #colorLiteral(red: 0.4864498352, green: 0.8406358007, blue: 0, alpha: 1)
        }
        UIView.animate(withDuration: 1) {
            self.ButtonOutLet.tintColor = #colorLiteral(red: 0.4578476902, green: 0.6071662624, blue: 0.818062356, alpha: 1)
        }
    }
    func animateTappedButton() {

        UIView.animate(withDuration: 0.5, animations: {
            self.ButtonOutLet.transform = CGAffineTransform(translationX: -0 , y:-50)
        }) { _  in
            self.ButtonOutLet.transform = .identity
        }
    }
}
