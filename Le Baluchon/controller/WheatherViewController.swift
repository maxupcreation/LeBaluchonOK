//
//  WheatherViewController.swift
//  Le Baluchon
//
//  Created by Maxime on 18/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class WheatherViewController: UIViewController {
    
    //MARK: - VARIABLE
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    
    @IBOutlet weak var temperatureLabelNewYork: UILabel!
    @IBOutlet weak var descriptiontextviewNewYork: UITextView!
    
     var weatherServicesAPI_Instance = WeatherServicesAPI()
    
   // **************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAPIAndUpdate()
    }
    
    // MARK: - START API
    
    func startAPIAndUpdate() {
        
        weatherServicesAPI_Instance.creationWeatherTaskRequest(for: "id=5128638,3027421") { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let dataWeatherInstance):
                    self.updateChambery(dataWeatherInstance : dataWeatherInstance)
                    self.updateNewyork(dataWeatherInstance: dataWeatherInstance)
                case .failure : self.presentAlert(message:"error")
                    
                }
            }
        }
    }
    
//MARK: - UPDATE VIEW
    
    private func updateNewyork(dataWeatherInstance: WeatherDataStruct){
        
        // DESCRIPTION NY
        descriptiontextviewNewYork.text = dataWeatherInstance.list[0].weather[0].weatherDescription
        
        //TEMPERATURE NY
        let temperature = String(dataWeatherInstance.list[0].main.temp)
        temperatureLabelNewYork.text = temperature
    }
    
    private func updateChambery(dataWeatherInstance: WeatherDataStruct){
        
        // DESCRIPTION CHY
        descriptionTxtView.text = dataWeatherInstance.list[0].weather[0].weatherDescription
        
        //TEMPERATURE CHY
        let temperature = String(dataWeatherInstance.list[0].main.temp)
        temperatureLabel.text = temperature + "" + "C°"
        
    }
    
    // MARK: - Alert
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
