//
//  WheatherViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 18/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class WheatherViewController: UIViewController {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    var weatherServicesAPI_Instance = WeatherServicesAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAPIAndUpdate()
     
    }
    
    
    func startAPIAndUpdate() {
        weatherServicesAPI_Instance.CreationWeatherTaskRequest() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataWeatherInstance):
                    self.update(dataWeatherInstance : dataWeatherInstance)
                    print(dataWeatherInstance.main.temp)
                case .failure : self.presentAlert(message:"error")
                }
            }
        }
    }
    
    func update(dataWeatherInstance: WeatherDataStruct){
        
        let temperature = "\(dataWeatherInstance.main.temp)"
        temperatureLabel.text = temperature
        print(temperature)
        
    }
    
  
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
