//
//  NetworkErrorEnum.swift
//  Le Baluchon
//
//  Created by Maxime on 23/10/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation

enum NetworkErrorEnum: Error, CustomStringConvertible {
    case noData
    case noResponse
    case undecodableData

    var description: String {
        switch self {
        case .noData:
            return "There is no data !"
        case .noResponse:
            return "Response status is incorrect !"
        case .undecodableData:
            return "Data can't be decoded !"
        }
    }
}


