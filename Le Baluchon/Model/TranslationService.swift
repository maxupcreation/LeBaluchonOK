//
//  TranslationServices.swift
//  Le Baluchon
//
//  Created by Maxime on 28/10/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation

class TranslationService {
    let httpClient : HTTPClient
    init(httpClient:HTTPClient = HTTPClient(httpEngine:HTTPEngine())) {
        self.httpClient = httpClient
    }
//MARK:- Translation
    func getTranslation(text: String, callback : @escaping (Result<GoogleTranslateDataStruct,NetworkErrorEnum>) -> Void ) {
        
        guard let baseUrl =  URL(string:"https://www.googleapis.com/language/translate/v2") else {return}
        let parameters = [("source","fr"),("target","en"),("format","text"),("key",ApiKeys.googleKey),("q",text)]
        
        httpClient.request(baseUrl: baseUrl, parameters: parameters, callback: callback)
    }
}
