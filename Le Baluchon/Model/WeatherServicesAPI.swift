//
//  WeatherServicesAPI.swift
//  Le Baluchon
//
//  Created by Maxime on 30/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit
class WeatherServicesAPI {
    
    //MARK: - VARIABLE
    
    //URL SESSION TASK INSTANCE
    private var task : URLSessionTask?
    
    // URL SESSION INSTANCE
    var session = URLSession(configuration: .default)
    init(session: URLSession = URLSession(configuration: .default))  {
        self.session  = session
    }
    //Poser la question sur l'init
    
    // ENUM FOR ERROR MANAGEMENT WITH RESULT
    enum NetWorkError: Error {
        case noData
        case noResponse
        case undecodable
    }
    
    //MARK: - TASK REQUEST
    
    // CREATE REQUEST
    func creationWeatherTaskRequest(for cityCode : String, callback : @escaping (Result<WeatherDataStruct,NetWorkError>)->Void) {
        
        task?.cancel()
        task = session.dataTask(with: request(cityCode: cityCode)) {
            (data, response, error) in
            
            // DATA CHEKING
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            // SUCCESS RESPONSE CHEKING
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            
            //JSON DECODER AND COMPARISON MODEL WITH RESPONSE
            guard let responseJSON = try? JSONDecoder().decode(WeatherDataStruct.self, from: data) else {
                callback(.failure(.undecodable))
                return
            }
            // RETURN DATA WITH CALLBACK
            callback(.success(responseJSON))
        }
        task?.resume()
    }
    
    // REQUEST URL
    func request(cityCode : String) -> URLRequest {
        let urlEnd = "&appid=106f0db32999088d061a4e175f721a8e&units=metric"
        let requestURL = URLRequest(url:URL(string:"https://api.openweathermap.org/data/2.5/weather?" + cityCode + urlEnd)!)
        return requestURL
    }
}
