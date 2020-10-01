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
        
        guard let url = URL(string:"http://data.fixer.io/api/latest?access_key=79d9d449523d341c9a5dd2d8b3328419&symbols=USD" ) else {return}
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






