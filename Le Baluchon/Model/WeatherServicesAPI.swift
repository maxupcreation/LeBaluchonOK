//
//  WeatherServicesAPI.swift
//  Le Baluchon
//
//  Created by Maxime on 30/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit
class WeatherServicesAPI {
    
    private var task : URLSessionTask?
    // faire l'init
    
    let session = URLSession(configuration: .default)
    
    enum NetWorkError: Error {
        case noData
        case noResponse
        case undecodable
    }
    
    
    func creationWeatherTaskRequest(for cityCode : String?, callback : @escaping (Result<WeatherDataStruct,NetWorkError>)->Void) {
        
        let urlEnd = "&APPID=106f0db32999088d061a4e175f721a8e&units=metric"
        
        guard let url = URL(string:"http://api.openweathermap.org/data/2.5/group?" + cityCode! + urlEnd) else { return }
        
        // guard let url = URL(string:"https://api.openweathermap.org/data/2.5/group?id=5128638,2968815&APPID=106f0db32999088d061a4e175f721a8e&units=metric") else {return}
        
        
        task?.cancel()
        task = session.dataTask(with: url) {
            (data, response, error) in
            
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            
            
            guard let responseJSON = try? JSONDecoder().decode(WeatherDataStruct.self, from: data) else {
                callback(.failure(.undecodable))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
