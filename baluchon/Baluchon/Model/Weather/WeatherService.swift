//
//  WeatherService.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 18/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

final class WeatherService{
    
// Get weather infos fot 2 citys (use citys id), one sesion, no request)
    
    init(weatherSession: URLSession = URLSession(configuration: .default)){
        self.weatherSession = weatherSession
    }
    
    static let openWeatherMapApiUrl = "http://api.openweathermap.org/data/2.5/group?"
    
    private var weatherTask: URLSessionDataTask?
    private var weatherSession: URLSession
    
    func getWeather(citysId: String, callback: @escaping (Bool, WeatherData?) -> Void){
        guard let url = URL(string: "\(WeatherService.openWeatherMapApiUrl)id=\(citysId)&units=metric&lang=fr&APPID=\(ApiKeysManager.openWeatherMapApiKey)") else{return}

        weatherTask?.cancel()
        
        weatherTask = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    print("error")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    print("error1")

                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else{
                    callback(false, nil)
                    print("error2")
                    return
                }
                callback(true, responseJSON.self)
            }
        }
        weatherTask?.resume()
    }
}

