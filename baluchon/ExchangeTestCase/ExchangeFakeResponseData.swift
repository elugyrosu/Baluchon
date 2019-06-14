//
//  ExchangeFakeResponseData.swift
//  ExchangeTestCase
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class ExchangeFakeResponseData{
    static let responseOK = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class ExchangeError: Error{}
    static let error = ExchangeError()
    
    static var exchangeCorrectData: Data?{
        let bundle = Bundle(for: ExchangeFakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static var exchangeSymbolsCorrectData: Data?{
        let bundle = Bundle(for: ExchangeFakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeSymbols", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    
    static let exchangeIncorrectData = "erreur".data(using: .utf8)!
    static let exchangeSymbolsIncorrectData = "erreur".data(using: .utf8)!
    
    
}
