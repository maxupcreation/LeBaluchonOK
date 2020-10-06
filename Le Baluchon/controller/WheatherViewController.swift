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
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAPIAndUpdateCHY()
        startAPIAndUpdateNY()
    }
    // MARK: - START API
    
    func startAPIAndUpdateCHY() {
        
        weatherServicesAPI_Instance.creationWeatherTaskRequest(for: "id=3027421") { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let dataWeatherInstance):
                    self.updateChambery(dataWeatherInstance : dataWeatherInstance)
                case .failure : self.presentAlert(message:"error")
                    
                }
            }
        }
    }
    
    func startAPIAndUpdateNY() {
        
        weatherServicesAPI_Instance.creationWeatherTaskRequest(for: "id=5128638") { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let dataWeatherInstance):
                    self.updateNewyork(dataWeatherInstance: dataWeatherInstance)
                case .failure : self.presentAlert(message:"error")
                    
                }
            }
        }
    }
    
    //MARK: - UPDATE VIEW
    
    private func updateNewyork(dataWeatherInstance: WeatherDataStruct){
        
        // DESCRIPTION NY
        descriptiontextviewNewYork.text = dataWeatherInstance.weather.first?.weatherDescription
        
        //TEMPERATURE NY
        let temperature = String(dataWeatherInstance.main.temp)
        temperatureLabelNewYork.text = temperature + " " + "C°"
    }
    
    private func updateChambery(dataWeatherInstance: WeatherDataStruct){
        
        // DESCRIPTION CHY
        descriptionTxtView.text = dataWeatherInstance.weather.first?.weatherDescription
        
        //TEMPERATURE CHY
        let temperature =  String(dataWeatherInstance.main.temp)
        temperatureLabel.text = temperature + " " + "C°"
    }
    
    // MARK: - ALERT
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
