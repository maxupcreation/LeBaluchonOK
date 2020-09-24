//
//  ConvertModel.swift
//  Le Baluchon
//
//  Created by Maxime on 24/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation

class ConvertModel {
    var euroTxtField = "56"
    lazy var convertTxtFieldInt = Double(euroTxtField)
    var resultConvert : Float?
    
    
    func convert() -> String  {
        
        func convertToEuro(value:Double, rate: Double) -> Double {
            return value / rate
        }
        
        let result = convertToEuro(value: convertTxtFieldInt!,rate: 2.3)
        // reconvertir le resultat en String et le renvoyer. 
    }
}
