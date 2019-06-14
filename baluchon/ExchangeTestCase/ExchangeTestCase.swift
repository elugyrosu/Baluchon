//
//  ExchangeTestCase.swift
//  ExchangeTestCase
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import XCTest

@testable import Baluchon

class ExchangeTestCase: XCTestCase {
    
    
    func testGetQuoteShouldPostFailedCallbackIfError(){
        let exchangeService = ExchangeService(
            exchangeSession: URLSessionFake(data: nil, response: nil, error: ExchangeFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeService.getExchange{ (success, exchange) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetQuoteShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeService = ExchangeService(
            exchangeSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeService.getExchange{ (success, exchange) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetQuoteShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let exchangeService = ExchangeService(
            exchangeSession: URLSessionFake(
                data: ExchangeFakeResponseData.exchangeIncorrectData,
                response: ExchangeFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeService.getExchange{ (success, exchange) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
}
