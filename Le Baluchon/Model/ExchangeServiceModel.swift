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
    
    
    func getConversionRequestUrl() -> URLRequest? {
        
        guard let conversionUrl = URL(string: "http://data.fixer.io/api/latest?access_key=79d9d449523d341c9a5dd2d8b3328419") else {
            return nil
        }
        var request = URLRequest(url: conversionUrl )
        request.httpMethod = "POST"
        
        
        /* let body = "method=getQuote&lang=en&format=json"
         request.httpBody = body.data(using: .utf8) */
        
        return request
    }
    
    func createConversionRequestTask(callback : @escaping (Result<ExchangeData,NetworkError>)->Void) {
        
        let request = getConversionRequestUrl()
        
        task = session.dataTask(with: request! ) {
            (data, response, error) in
            
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            
        }
        
        task?.resume()
        
    }
    
    
}
