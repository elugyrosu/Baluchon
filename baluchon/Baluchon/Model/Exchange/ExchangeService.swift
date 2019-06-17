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
    
    private let exchangeUrl = URL(string: "\(fixerApiUrl)latest?access_key=\(ApiKeysManager.fixerApiKey)&base=EUR")
    private let symbolsUrl = URL(string: "\(fixerApiUrl)symbols?access_key=\(ApiKeysManager.fixerApiKey)")

    
    static let fixerApiUrl = "http://data.fixer.io/api/"
    
    private var exchangeTask: URLSessionDataTask?
    private var symbolsTask: URLSessionDataTask?
    private var exchangeSession: URLSession
    
    
    func getExchange(callback: @escaping (Bool, [String: Double]?) -> Void){
        //        let request = createExchangeRequest()
        guard let url = exchangeUrl else{return}
        exchangeTask?.cancel()
        
        exchangeTask = exchangeSession.dataTask(with: url) { (data, response, error) in
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
        exchangeTask?.resume()
    }
    func getSymbols(callback: @escaping (Bool, [String: String]?) -> Void){
        //        let request = createExchangeRequest()
        guard let url = symbolsUrl else{return}
        symbolsTask?.cancel()
        
        symbolsTask = exchangeSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ExchangeSymbols.self, from: data) else{
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.symbols)
            }
        }
        symbolsTask?.resume()
    }
}

