//
//  WeatherFakeDataResponse.swift
//  WeatherTestCase
//
//  Created by Jordan MOREAU on 26/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class WeatherFakeResponseData{
    static let responseOK = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class WeatherError: Error{}
    static let error = WeatherError()
    
    static var weatherCorrectData: Data?{
        let bundle = Bundle(for: WeatherFakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    
    
}
