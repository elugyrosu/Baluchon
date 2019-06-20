//
//  WeatherService.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 18/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class WeatherService{
    
    init(weatherSession: URLSession = URLSession(configuration: .default)){
        self.weatherSession = weatherSession
    }
    
    private let weatherUrl = URL(string: "\(openWeatherMapApiUrl)q=new york&units=metric&lang=fr&\(ApiKeysManager.openWeatherMapApiKey)")
    
    
    static let openWeatherMapApiUrl = "api.openweathermap.org/data/2.5/weather?"
    
    private var weatherTask: URLSessionDataTask?
    private var weatherSession: URLSession
    
    
    func getWeather(callback: @escaping (Bool, WeatherData?) -> Void){
        //        let request = createExchangeRequest()
        guard let url = weatherUrl else{return}
        weatherTask?.cancel()
        
        weatherTask = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else{
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.self)
            }
        }
        weatherTask?.resume()
    }

}

