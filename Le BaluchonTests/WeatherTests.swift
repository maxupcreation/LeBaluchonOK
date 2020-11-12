//
//  WeatherTests.swift
//  Le BaluchonTests
//
//  Created by Maxime on 06/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class WeatherTests: XCTestCase {
    //CORRECT
    func testDataWeather_WhenCallWeatherNetWork_ThenReturnValueWithDataStruct() {
        let fakeSession = URLSessionFake(data: FakeResponseData.weathersCorrectData, response: FakeResponseData.responseOK, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let exchangeService = WeatherService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
        exchangeService.getWeather { (result) in
            guard case .success(let data) = result else {
                XCTFail("testDataWeather_WhenCallWeatherNetWork_ThenReturnValueWithDataStruct")
                return
            }
            XCTAssertEqual(data.list[1].main.temp,12.12)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    //ERROR
    func testErrorWeather_WhenUrlWeatherIsBroken_ThenShouldReturnAnError() {
        let fakeSession = URLSessionFake(data: FakeResponseData.weathersCorrectData, response: FakeResponseData.responseKO, error: FakeResponseData.error)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let weatherService = WeatherService(httpClient: httpClient)
        
        let expectation = XCTestExpectation(description: "Waiting")
        weatherService.getWeather { (result) in
            guard case .failure(let error) = result else {
            XCTFail("testErrorWeather_WhenUrlWeatherIsBroken_ThenReturnError")
            return
        }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testErrorWeather_WhenIncorrectDataAndCorrectResponseIsPassed_ThenShouldReturnAnError() {
           let fakeSession = URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: FakeResponseData.error)
           
           let httpEngine = HTTPEngine(session: fakeSession)
           let httpClient = HTTPClient(httpEngine: httpEngine)
           let weatherService = WeatherService(httpClient: httpClient)
           
           let expectation = XCTestExpectation(description: "Waiting")
           weatherService.getWeather { (result) in
               guard case .failure(let error) = result else {
               XCTFail("testErrorWeather_WhenUrlWeatherIsBroken_ThenReturnError")
               return
           }
               XCTAssertNotNil(error)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
    
}



