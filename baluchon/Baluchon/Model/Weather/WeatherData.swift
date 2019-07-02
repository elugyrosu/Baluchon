//
//  WeatherData.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 20/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// Datas we want to decode from JSON (here all weather infos) we have to respect JSON Structure


struct WeatherData: Decodable{
    let list: [List]
}

struct List: Decodable {
    let main: [String: Double]
    let weather: [Weather]
    let wind: [String:Double]
    let name: String
}

struct Weather: Decodable{
    let main: String
    let description: String
    let icon: String
}


