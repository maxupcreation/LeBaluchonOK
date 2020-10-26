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
    
    @IBOutlet weak var euroTxtField: UITextField!
    
    @IBOutlet weak var ButtonOutLet: UIButton!
    @IBOutlet weak var dollarResultLabel: UILabel!
    
    // Model instance template
    private let httpClient: HTTPClient = HTTPClient()
    
    //MARK:- COLOR AND ANIMATE
    
    func animateTappedButton() {
        
        SystemSoundID.playFileNamed(fileName: "encaissement-dargent-bruitage", withExtenstion: ".mp3")
        
        //EURO TXT FIELD ANIMATION
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .autoreverse, animations: {
            self.euroTxtField.transform = CGAffineTransform(translationX: -0 , y:10)
            
        }) { _  in
            
            
            self.euroTxtField.transform = .identity
        }
        
        //ARROW BUTTON ANIMATION WITH DELAY
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.2, options: .autoreverse, animations: {
            self.ButtonOutLet.transform = CGAffineTransform(translationX: -0 , y:10)
            
        }) { _  in
            self.ButtonOutLet.transform = .identity
            
        }
        
        //RESULT BUTTON ANIMATION WITH DELAY
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.3, options: .autoreverse, animations: {
            self.dollarResultLabel.transform = CGAffineTransform(translationX: -0, y: -5)
            
        }) { _  in
            self.dollarResultLabel.transform = .identity
        }
    }
    
    
    func color() {
        self.ButtonOutLet.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.euroTxtField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.euroTxtField.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.euroTxtField.layer.cornerRadius = 20
        
        self.dollarResultLabel.backgroundColor = #colorLiteral(red: 0.4864498352, green: 0.8406358007, blue: 0, alpha: 1)
        self.dollarResultLabel.layer.cornerRadius = 20
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
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func tappedArrowConversionButton() {
        
        animateTappedButton()
    
        
        //CALL NETWORK
         guard let urlExchange = URL(string: "http://data.fixer.io/api/latest?access_key=79d9d449523d341c9a5dd2d8b3328419&symbols=USD") else {return}
        
        
        httpClient.request(baseUrl:urlExchange, parameters: nil) { (result :Result<ExchangeDataStruct, NetworkErrorEnum>) in
            switch result {
                
                
            case .success(let data): update(data: data)
            case .failure(let error): self.showAlert(with:error.description)
                
            }
            
        }
        
        func update(data : ExchangeDataStruct) {
            DispatchQueue.main.async {
                let result = convert(value: self.euroTxtField.text ?? "", rates: data)
                self.dollarResultLabel.text = result
            }
        }
        
        func convert(value: String, rates: ExchangeDataStruct) -> String  {
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

