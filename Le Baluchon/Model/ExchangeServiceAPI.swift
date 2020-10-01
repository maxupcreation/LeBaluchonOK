//
//  File.swift
//  Le Baluchon
//
//  Created by Maxime on 18/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit
class  ExchangeServiceAPI {
    
    private var task : URLSessionTask?
    init(){}
    
    let session = URLSession(configuration: .default)
    
    
    enum NetworkError  : Error {
        case noData
        case noResponse
        case undecodable
    }
    
    
    func createConversionRequestTask(callback : @escaping (Result<ExchangeData,NetworkError>)->Void) {
        
        guard let url = URL(string:"api.openweathermap.org%2Fdata%2F2.5%2Fweather%3Fq%3DChambery%26appid%3D106f0db32999088d061a4e175f721a8e" ) else {return}
        
        
        task?.cancel()
        task = session.dataTask(with: url ) {
            (data, response, error) in
            
            // vérifie si il y a des données
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(ExchangeData.self, from: data) else {
                callback(.failure(.undecodable))
                return
            }
            callback(.success(responseJSON))
            
        }
        task?.resume()
    }
    
}






