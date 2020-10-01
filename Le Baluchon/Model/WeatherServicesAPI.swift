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
    
    let session = URLSession(configuration: .default)
    
    enum NetWorkError: Error {
        case noData
        case noResponse
        case undecodable
    }
    
    func CreationWeatherTaskRequest(callback : @escaping (Result<WeatherDataStruct,NetWorkError>)->Void) {
        
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?id=3027421&appid=106f0db32999088d061a4e175f721a8e" ) else {return}
        
        task?.cancel()
        task = session.dataTask(with: url ) {
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







