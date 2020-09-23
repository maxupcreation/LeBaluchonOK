//
//  File.swift
//  Le Baluchon
//
//  Created by Maxime on 18/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation
class  ExchangeServiceModel {
    
    
    private var task : URLSessionTask?
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
            
            //décodage des données de l'API
           // guard (try? JSONDecoder().decode(ExchangeData.self, from: data)) != nil else {
             //   return callback(.failure(.undecodable)) }
            
            
            /* guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data!),
             let timeStamp = responseJSON["timestamp"],
             let base = responseJSON["EUR"],
             let date = responseJSON["date"],
             let rates = responseJSON["rates"]
             else {
             callback(.failure(.noResponse))
             
             } */
        }
        task?.resume()
    }
    
}








