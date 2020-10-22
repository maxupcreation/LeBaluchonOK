//
//  TraductionViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 18/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class TraductionViewController: UIViewController {
    
    @IBOutlet weak var buttonForTraduction: UIButton!
    @IBOutlet weak var editableTXTField: UITextField!
    
    @IBOutlet weak var resultTranslateTxtField: UITextField!
    
    var translateGoogleAPIInstance = TranslateGoogleAPI()
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - BUTTON ACTION & UPDATE
    
    @IBAction func tappedTranslateButton(_ sender: Any) {
        
        translateGoogleAPIInstance.createConversionRequestTask(txt:editableTXTField.text) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let LanguageTranslateDataInstance) :
                    self.update(dataInstance: LanguageTranslateDataInstance)
                case .failure(let error) : self.presentAlert(message: error.localizedDescription)
                    
                }
                
            }
        }
    }
    
    //MARK: - UDPATE
    private func update(dataInstance : GoogleTranslate ){
        self.resultTranslateTxtField.text = dataInstance.data.translations[0].translatedText
    }
    
    // MARK: - ALERT
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
}
