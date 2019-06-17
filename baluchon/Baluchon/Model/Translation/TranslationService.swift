//
//  TranslationService.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 15/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

protocol DisplayAlert {
    func showAlert(message: String)
}


class TranslationService{
    
    init(translateSession: URLSession = URLSession(configuration: .default)){
        self.translateSession = translateSession
    }
    
    static let apiUrl = "https://translation.googleapis.com/language/translate/v2/"

    private let translateUrl = URL(string: "\(apiUrl)?key=\(ApiKeysManager.translateApiKey)")
    private let languagesUrl = URL(string: "https://translation.googleapis.com/language/translate/v2/languages?key=\(ApiKeysManager.translateApiKey)&target=fr")
    
    
    private var languagesTask: URLSessionDataTask?
    private var translateTask: URLSessionDataTask?
    private var translateSession: URLSession

    
    func getLanguages(callback: @escaping (Bool, DataClass?) -> Void){
        //        let request = createExchangeRequest()
        guard let url = languagesUrl else{return}
        languagesTask?.cancel()
        
        languagesTask = translateSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslationSymbols.self, from: data) else{
                    callback(false, nil)
                    return
                }
                
                callback(true, responseJSON.data)
            }
        }
        languagesTask?.resume()
    }
    
}
