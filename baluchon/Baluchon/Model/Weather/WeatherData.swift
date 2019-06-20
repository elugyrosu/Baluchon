//
//  WeatherData.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 20/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let name: String
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin: Double
    let tempMax: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}


// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
