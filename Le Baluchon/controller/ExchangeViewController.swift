//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 17/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//
import AudioToolbox
import UIKit

class ExchangeViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - VARIABLE
    @IBOutlet weak var dollarButtonOutlet: UIButton!
    
    @IBOutlet weak var GBPButtonOutlet: UIButton!
    @IBOutlet weak var euroTxtField: UITextField!
    
    @IBOutlet weak var ButtonOutLet: UIButton!
    @IBOutlet weak var dollarResultLabel: UILabel!
    
    var symbols = "USD"
    
    private let exchangeService = ExchangeService()
    
    //MARK:- COLOR AND ANIMATE
    
    func animateTappedButton() {
        
        SystemSoundID.playFileNamed(fileName: "encaissement-dargent-bruitage", withExtenstion: ".mp3")
        
        
        //ARROW BUTTON ANIMATION WITH DELAY
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .autoreverse, animations: {
            self.ButtonOutLet.transform = CGAffineTransform(translationX: -0 , y:10)
            
        }) { _  in
            self.ButtonOutLet.transform = .identity
            
        }
        
        //RESULT BUTTON ANIMATION WITH DELAY
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.1, options: .autoreverse, animations: {
            self.dollarResultLabel.transform = CGAffineTransform(translationX: -0, y: 5)
            
        }) { _  in
            self.dollarResultLabel.transform = .identity
        }
    }
    
    //************//COLOR\\************
    
    func color() {
        self.ButtonOutLet.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.euroTxtField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.euroTxtField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.euroTxtField.layer.cornerRadius = 20
        
       
        self.dollarResultLabel.layer.masksToBounds = true
        self.dollarResultLabel.layer.cornerRadius = 20
 
        GBPButtonOutlet.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        dollarButtonOutlet.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        symbols = "USD"
        GBPButtonOutlet.alpha = 0.5
        dollarButtonOutlet.alpha = 1
        
        color()
    }
    
    //MARK: - BUTTON ACTION & UPDATE
    
    //KEYBOARD GESTION
    @IBAction func dismissKeyboard(_ sender: Any) { euroTxtField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        euroTxtField.resignFirstResponder()
        return true
    }
    
    //BUTTON CONVERSION
    
    @IBAction func GBPButtonTapped(_ sender: Any) {
        symbols = "GBP"
        
        GBPButtonOutlet.alpha = 1
        dollarButtonOutlet.alpha = 0.5
        
        GBPButtonOutlet.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        dollarButtonOutlet.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
    }
    
    @IBAction func dollarButtonTapped(_ sender: Any) {
        symbols = "USD"
        
        GBPButtonOutlet.alpha = 0.5
        dollarButtonOutlet.alpha = 1
        
        GBPButtonOutlet.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        dollarButtonOutlet.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        
    }
    
    
    
    @IBAction func tappedArrowConversionButton() {
        
        animateTappedButton()
        
        exchangeService.getExchange(symbols:symbols) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data): update(data: data)
                case .failure(let error): self.showAlert(with:error.description)
                    
                }
            }
        }
        
        func update(data : ExchangeDataStruct) {
            DispatchQueue.main.async {
                let result = convert(value: self.euroTxtField.text ?? "", rates: data)
                self.dollarResultLabel.text = result
            }
        }
        
        func convert(value: String, rates: ExchangeDataStruct) -> String  {
            guard let rate = rates.rates[symbols] else { return "NA" }
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
}

extension SystemSoundID {
    static func playFileNamed(fileName: String, withExtenstion fileExtension: String) {
        var sound: SystemSoundID = 0
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
    }
}

extension UIViewController {
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

