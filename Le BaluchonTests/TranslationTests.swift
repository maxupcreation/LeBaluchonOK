//
//  TranslationTests.swift
//  Le BaluchonTests
//
//  Created by Maxime on 06/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class TranslationTests: XCTestCase {
    func testGetTranslationService_WhenCorrectDataAndCorrectResponseIsPassed_ThenShouldCorrectData() {
        let fakeSession = URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let translationService = TranslationService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
        translationService.getTranslation(text: "bonjour monsieur") { (result) in
            guard case .success(let data) = result else {
                XCTFail("testDataWeather_WhenCallWeatherNetWork_ThenReturnValueWithDataStruct")
                return
            }
            XCTAssertEqual("Hello sir",data.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetExchangeMethod_WhenCorrectDataAndIcorrectResponseIsPassed_ThenShouldReturnAnError() {
           let fakeSession = URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil)
           
           let httpEngine = HTTPEngine(session: fakeSession)
           let httpClient = HTTPClient(httpEngine: httpEngine)
           let translateService = TranslationService(httpClient: httpClient)
           
           let expectation = XCTestExpectation(description: "Waiting")
        translateService.getTranslation(text: "bonjour monsieur") { (result) in
               guard case .failure(let error) = result else {
                   XCTFail("testDataExchange_WhenCallExchangeNetWork_ThenReturnValueWithDataStruct")
                   return
               }
               XCTAssertNotNil(error)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
    
    
    func testGetTranslateMethod_WhenIncorrectDataAndIncorrectResponseIsPassed_ThenShouldReturnAnError() {
        let fakeSession = URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let translateService = TranslationService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
     translateService.getTranslation(text: "bonjour monsieur") { (result) in
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
