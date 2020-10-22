//
//  TranslateGoogleAPI.swift
//  Le Baluchon
//
//  Created by Maxime on 13/10/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation
class TranslateGoogleAPI {

    
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
    
    func createConversionRequestTask(txt : String?, callback : @escaping (Result<GoogleTranslate,NetWorkError>)->Void) {
        let apikeysInstance = ApiKeys()
    
           guard let textEncoded = txt?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        let urlString = "https://www.googleapis.com/language/translate/v2?key=" + apikeysInstance.apiKeys + textEncoded
    
        print(urlString)
        guard let googleUrl = URL(string: urlString ) else {return}
        
        task?.cancel()
        task = session.dataTask(with:googleUrl) {
            (data, response, error) in
            
            // DATA CHEKING
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                print(NetWorkError.noData)
                return
            }
            
            // SUCCESS RESPONSE CHEKING
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.noResponse))
                print(NetWorkError.noResponse)
                return
            }
            
            //JSON DECODER AND COMPARISON MODEL WITH RESPONSE
            guard let responseJSON = try? JSONDecoder().decode(GoogleTranslate.self, from: data) else {
                callback(.failure(.undecodable))
                print(NetWorkError.undecodable)
                return
            }
            // RETURN DATA WITH CALLBACK
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
