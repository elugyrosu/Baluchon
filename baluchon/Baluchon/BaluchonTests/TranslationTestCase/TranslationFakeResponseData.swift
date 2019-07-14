//
//  TranslationFakeResponseData.swift
//  TranslationTestCase
//
//  Created by Jordan MOREAU on 24/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation


class TranslationFakeResponseData{
    static let responseOK = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class TranslationError: Error{}
    static let error = TranslationError()
    
    static var translationCorrectData: Data?{
        let bundle = Bundle(for: TranslationFakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static var languagesSymbolsCorrectData: Data?{
        let bundle = Bundle(for: TranslationFakeResponseData.self)
        let url = bundle.url(forResource: "Languages", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    
    static let translationtIncorrectData = "erreur".data(using: .utf8)!
    static let languagesSymbolsIncorrectData = "erreur".data(using: .utf8)!
    
    
}
