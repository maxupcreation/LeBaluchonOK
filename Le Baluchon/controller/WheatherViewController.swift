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
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var temperatureLabelNewYork: UILabel!
    @IBOutlet weak var descriptiontextviewNewYork: UILabel!
    
    @IBOutlet weak var newYorkLabel: UILabel!
    @IBOutlet weak var chamberyLabel: UILabel!
    
    
    // Model instance template
    private let httpClient: HTTPClient = HTTPClient()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorLabel()
        startAPIAndUpdate()
    }
    // MARK: - START API
    
    func startAPIAndUpdate() {
        
        guard let urlExchange = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128638,3027421&APPID=106f0db32999088d061a4e175f721a8e&units=metric") else {return}
        
        
        httpClient.request(baseUrl:urlExchange, parameters: nil) { (result :Result<WeatherDataStruct, NetworkErrorEnum>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) : self.updateNewyork(dataWeatherInstance: data)
                self.updateChambery(dataWeatherInstance: data)
                case .failure(let error): self.showAlert(with: error.description)
                }
            }
        }
    }
    
    //MARK: - UPDATE VIEW
    
    private func updateNewyork(dataWeatherInstance: WeatherDataStruct){
        
        // DESCRIPTION NY
        descriptiontextviewNewYork.text = dataWeatherInstance.list[0].weather.first?.description
        
        //TEMPERATURE NY
        let temperature = String(dataWeatherInstance.list[0].main.temp)
        temperatureLabelNewYork.text = temperature + " °C"
    }
    
    private func updateChambery(dataWeatherInstance: WeatherDataStruct){
        
        // DESCRIPTION CHY
        descriptionLabel.text = dataWeatherInstance.list[1].weather.first?.description
        
        //TEMPERATURE CHY
        let temperature =  String(dataWeatherInstance.list[1].main.temp)
        temperatureLabel.text = temperature + " °C"
    }
    
    // MARK: - ALERT
    
    func presentAlert(message : String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - COLOR AND ANIMATE
    
    func colorLabel() {
        
        
        
        temperatureLabelNewYork.textColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        temperatureLabelNewYork.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        temperatureLabelNewYork.layer.cornerRadius = 15
        temperatureLabelNewYork.layer.masksToBounds = true
        
        
        
        
        temperatureLabel.textColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        temperatureLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        temperatureLabel.layer.cornerRadius = 15
        temperatureLabel.layer.masksToBounds = true
        
        
        
        
    }
    
    
    
    
}
