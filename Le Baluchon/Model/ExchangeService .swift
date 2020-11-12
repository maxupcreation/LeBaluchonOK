//
//  File.swift
//  Le Baluchon
//
//  Created by Maxime on 05/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation
class ExchangeService {
    let httpClient : HTTPClient
       init(httpClient:HTTPClient = HTTPClient(httpEngine:HTTPEngine())) {
           self.httpClient = httpClient
       }
    //MARK:- Exchange
    
    //http://data.fixer.io/api/latest?access_key=79d9d449523d341c9a5dd2d8b3328419&symbols=USD
    func getExchange(symbols : String, callback : @escaping (Result<ExchangeDataStruct,NetworkErrorEnum>) -> Void ) {
        
        //CALL NETWORK
        guard let urlExchange = URL(string: "http://data.fixer.io/api/latest?") else {return}
     let parameters = [("access_key","79d9d449523d341c9a5dd2d8b3328419"),("symbols", symbols)]
        httpClient.request(baseUrl: urlExchange, parameters: parameters, callback: callback)
    }
}
