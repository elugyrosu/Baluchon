//
//  WeatherTestCase.swift
//  WeatherTestCase
//
//  Created by Jordan MOREAU on 26/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//
@testable import Baluchon
import XCTest

class WeatherTestCase: XCTestCase {
    
    func testGetExchangeShouldPostFailedCallbackIfError(){
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetExchangeShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    
    func testGetExchangeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: WeatherFakeResponseData.weatherCorrectData,
                response: WeatherFakeResponseData.responseKO,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetExchangeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: WeatherFakeResponseData.weatherIncorrectData,
                response: WeatherFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetExchangeShouldPostSuccessCallbackAndCorrectData(){
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: WeatherFakeResponseData.weatherCorrectData,
                response: WeatherFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, weather) in

            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            XCTAssertEqual("Nice", weather?.list[0].name)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }



}
