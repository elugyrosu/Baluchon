//
//  WeatherData.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 20/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let main: [String: Double]
    let weather: [Weather]
    let wind: [String:Double]
    
}
struct Weather: Decodable{
    let main: String
    let description: String
    let icon: String
}


