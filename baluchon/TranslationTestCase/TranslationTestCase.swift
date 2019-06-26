//
//  TranslationTestCase.swift
//  TranslationTestCase
//
//  Created by Jordan MOREAU on 24/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

@testable import Baluchon

import XCTest

class TranslationTestCase: XCTestCase {

    func testGetTranslationShouldPostFailedCallbackIfError(){
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: TranslationFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.translationCorrectData,
                response: TranslationFakeResponseData.responseKO,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.translationtIncorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostSuccessCallbackAndCorrectData(){
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.translationCorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour, je m'appelle Alfred"){ (success, translation) in

            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            
            XCTAssertEqual("Hello, my name is Alfred", translation?.translations[0].translatedText)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //    MARK: LanguagesTest
    
    func testGetLanguagesShouldPostFailedCallbackIfError(){
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: TranslationFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguagesShouldPostFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetLanguagesShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.languagesSymbolsCorrectData,
                response: TranslationFakeResponseData.responseKO,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetLanguagesShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.languagesSymbolsIncorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetLanguagesShouldPostSuccessCallbackAndCorrectData(){
        // Given
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.languagesSymbolsCorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getLanguages(){ (success, languages) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(languages)

            XCTAssertEqual("af", languages?.languages[0].language)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }



}
