//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Maxime on 05/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation

class WeatherService{
    let httpClient : HTTPClient
       init(httpClient:HTTPClient = HTTPClient(httpEngine:HTTPEngine())) {
           self.httpClient = httpClient
       }
  
//MARK:- Weather
    
    //http://api.openweathermap.org/data/2.5/group?id=5128638,3027421&APPID=106f0db32999088d061a4e175f721a8e&units=metric
    func getWeather(callback :@escaping(Result<WeatherDataStruct,NetworkErrorEnum>) -> Void) {
        
        guard let urlWeather = URL(string: "http://api.openweathermap.org/data/2.5/group?") else {return}
        let parameters = [("id","5128638,3027421"),("APPID","106f0db32999088d061a4e175f721a8e"),("units","metric")]
        
        httpClient.request(baseUrl: urlWeather, parameters: parameters, callback: callback)
    }
}
