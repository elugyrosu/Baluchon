//
//  ExchangeService.swift
//  BaluchonTests
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class ExchangeService{
    
    init(exchangeSession: URLSession = URLSession(configuration: .default)){
        self.exchangeSession = exchangeSession
    }
    private let exchangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=12bb2b6a3892b617111ae232d072fcfb&base=EUR")
    private let symbolsUrl = URL(string: "http://data.fixer.io/api/symbols?access_key=12bb2b6a3892b617111ae232d072fcfb")

    
    private var task: URLSessionDataTask?
    private var exchangeSession: URLSession
    
    
    
    func getExchange(callback: @escaping (Bool, [String: Double]?) -> Void){
        //        let request = createExchangeRequest()
        guard let url = exchangeUrl else{return}
        task?.cancel()
        
        task = exchangeSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Exchange.self, from: data) else{
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.rates)
            }
        }
        task?.resume()
    }
    func getSymbols(callback: @escaping (Bool, [String: String]?) -> Void){
        //        let request = createExchangeRequest()
        guard let url = symbolsUrl else{return}
        task?.cancel()
        
        task = exchangeSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(PickerViewSymbols.self, from: data) else{
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.symbols)
            }
        }
        task?.resume()
    }
}

