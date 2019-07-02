//
//  ApiKeys.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 15/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// get API Keys from ApiKeys.plist (git ignored) -> NS Dictionnary

final class ApiKeysManager{
    
    private static var apiKeysPlist: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else{
                fatalError("no dictionnary")
        }
        return NSDictionary(contentsOfFile: path) ?? [:]
        
    }()
    static var fixerApiKey: String {
        return apiKeysPlist["fixerApiKey"] as? String ?? String()
    }
    static var translateApiKey: String{
        return apiKeysPlist["googleTranslateApiKey"] as? String ?? String()
    }
    static var openWeatherMapApiKey: String{
        return apiKeysPlist["openWeatherMapApiKey"] as? String ?? String()
    }
}
