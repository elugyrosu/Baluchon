//
//  ExchangeTest.swift
//  ExchangeTest
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

@testable import Baluchon
import XCTest

class ExchangeTestCase: XCTestCase {
    
    func testGetExchangeShouldPostFailedCallbackIfError(){
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
    func testGetExchangeShouldPostFailedCallbackIfNoData() {
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
    
    
    // ERREUR
    
    func testGetExchangeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeService(
            exchangeSession: URLSessionFake(
                data: ExchangeFakeResponseData.exchangeCorrectData,
                response: ExchangeFakeResponseData.responseKO,
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
    
    func testGetExchangeShouldPostFailedCallbackIfIncorrectData() {
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
