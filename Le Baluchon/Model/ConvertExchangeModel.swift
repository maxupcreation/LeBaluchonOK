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
    var rates : Double?
    
    
    
    
    func convert() -> String  {
       
            func convertToEuro(value: Double, rate: Double) -> Double {
                return value / rate
            }
            let result = String(convertToEuro(value: convertTxtFieldInt!, rate: rates!))
            
        return result
        
    }
}
