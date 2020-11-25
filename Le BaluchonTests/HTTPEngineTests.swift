//
//  HTTPEngineTests.swift
//  Le BaluchonTests
//
//  Created by Maxime on 04/11/2020.
//  Copyright © 2020 Maxime. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class HTTPEngineTests: XCTestCase {
   /* INDICATION
     // appellé à chaque début de test
    override func setUp() {
        <#code#>
    }
    // appellé à la fin de chaque test
    override func tearDown() {
        <#code#>
    } */
    
    func testRequestMethod_WhenAnErrorInGiven_ThenShouldReturnFailedCallback() {
        let fakeSession = URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting")
        httpEngine.request(baseUrl: URL(string: "www.apple.com")!, parameters: nil) { data, response, error  in
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
           expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testDataIsNotNil_WhenResponseAndDataIsRequested_ThenShouldReturnIsNotNil() {
        let fakeSession = URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil)
        
        let httpEngine = HTTPEngine(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting")
        httpEngine.request(baseUrl: URL(string: "www.apple.com")!, parameters: nil) { data, response, error  in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
           expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
