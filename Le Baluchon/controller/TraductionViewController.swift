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
    
       // Model instance template
     private let httpClient: HTTPClient = HTTPClient()
   
    
     private  let apikeysInstance = ApiKeys()
    
    //https://www.googleapis.com/language/translate/v2?key=AIzaSyAXWTzvN_fMZEWPCviks--4ywiZ-ZT3LCw&source=fr&target=en&format=text&q=
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - BUTTON ACTION & UPDATE
    
    @IBAction func tappedTranslateButton(_ sender: Any) {
        
        guard let urlTrad = URL(string: "https://www.googleapis.com/language/translate/v2?" + apikeysInstance.apiKeys + "&source=fr&target=en&format=text&") else {return}
          
          
        httpClient.request(baseUrl:urlTrad, parameters: [("q",editableTXTField.text!)]) { (result :Result<GoogleTranslate,NetworkErrorEnum>) in
              DispatchQueue.main.async {
                  switch result {
                  case .success(let dataInstance): self.update(dataInstance: dataInstance)
                  case .failure(let error): self.showAlert(with: error.description)
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
