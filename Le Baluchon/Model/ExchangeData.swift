//
//  File.swift
//  Le Baluchon
//
//  Created by Maxime on 21/09/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation

// MARK: - ExchangeData

struct ExchangeData: Decodable {
    let rates: [String : Double]
}

