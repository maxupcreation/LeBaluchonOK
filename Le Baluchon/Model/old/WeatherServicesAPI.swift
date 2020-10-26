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
    
    // ENUM FOR ERROR MANAGEMENT WITH RESULT
    enum NetWorkError: Error {
        case noData
        case noResponse
        case undecodable
    }
    
    //MARK: - TASK REQUEST
    
    // CREATE REQUEST
    func creationWeatherTaskRequest(callback : @escaping (Result<WeatherDataStruct,NetWorkError>)->Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128638,3027421&APPID=106f0db32999088d061a4e175f721a8e&units=metric") else {return}
        
        task?.cancel()
        task = session.dataTask(with:url) {
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
}
