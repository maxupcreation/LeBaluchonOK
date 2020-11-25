//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Maxime on 02/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import Foundation
class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.apple.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.apple.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let error = NetworkError()
    
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
    
    static var weathersCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}
