//
//  ConvertExchangeModel.swift
//  Le Baluchon
//
//  Created by Maxime on 25/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import UIKit

class ConvertExchangeModel {
    var euroTxtField = ""
    lazy var convertTxtFieldInt = Double(euroTxtField)
    var instanceOfExchangeData = ExchangeData.init(rates: ["USD":0])
  
    
    
    
    func convert() -> String  {
    let rates = instanceOfExchangeData.rates["USD"]
        if rates != nil {
            func convertToEuro(value: Double, rate: Double) -> Double {
                return value / rate
            }
            
            // ajouter à condition d'être différent de nil
            let result = String(convertToEuro(value: convertTxtFieldInt!, rate: rates!))
            return result
        }
      return "error"
    }
}
