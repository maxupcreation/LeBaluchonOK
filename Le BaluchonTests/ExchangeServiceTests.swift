//
//  ExchangeTests.swift
//  Le BaluchonTests
//
//  Created by Maxime on 04/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class ExchangeServiceTests: XCTestCase {
    
    func testDataExchange_WhenCallExchangeNetWork_ThenShouldReturnCorrectValue() {
        let fakeSession = URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let exchangeService = ExchangeService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
        exchangeService.getExchange { (result) in
            guard case .success(let data) = result else {
                XCTFail("testDataExchange_WhenCallExchangeNetWork_ThenReturnValueWithDataStruct")
                return
            }
            XCTAssertEqual(data.rates["USD"]!,1.17075)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeMethod_WhenCorrectDataAndIcorrectResponseIsPassed_ThenShouldReturnAnError() {
        let fakeSession = URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let exchangeService = ExchangeService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
        exchangeService.getExchange { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testDataExchange_WhenCallExchangeNetWork_ThenReturnValueWithDataStruct")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeMethod_WhenIncorrectDataAndCorrectResponseIsPassed_ThenShouldReturnAnError() {
        let fakeSession = URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let exchangeService = ExchangeService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
        exchangeService.getExchange { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testDataExchange_WhenCallExchangeNetWork_ThenReturnValueWithDataStruct")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
