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
    
    //  MARK: getTranslation tests

    func testGetTranslationShouldPostFailedCallbackIfError(){
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: TranslationFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.translationCorrectData,
                response: TranslationFakeResponseData.responseKO,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.translationtIncorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(translationLanguage:"en",textToTranslate: "Bonjour"){ (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackAndCorrectData(){
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
    
    //  MARK: getLanguages Test
    
    func testGetLanguagesShouldPostFailedCallbackIfError(){
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: TranslationFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguagesShouldPostFailedCallbackIfNoData() {
        let translationService = TranslationService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguagesShouldPostFailedCallbackIfIncorrectResponse() {
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.languagesSymbolsCorrectData,
                response: TranslationFakeResponseData.responseKO,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguagesShouldPostFailedCallbackIfIncorrectData() {
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.languagesSymbolsIncorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getLanguages(){ (success, languages) in
            XCTAssertFalse(success)
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguagesShouldPostSuccessCallbackAndCorrectData(){
        let translationService = TranslationService(
            translateSession: URLSessionFake(
                data: TranslationFakeResponseData.languagesSymbolsCorrectData,
                response: TranslationFakeResponseData.responseOK,
                error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getLanguages(){ (success, languages) in
            XCTAssertTrue(success)
            XCTAssertNotNil(languages)
            XCTAssertEqual("af", languages?.languages[0].language)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
