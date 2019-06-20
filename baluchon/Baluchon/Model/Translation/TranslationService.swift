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
    private var displayAlertDelegate: DisplayAlert?
    static let apiUrl = "https://translation.googleapis.com/language/translate/v2/"

    private let languagesUrl = URL(string: "\(apiUrl)languages?key=\(ApiKeysManager.translateApiKey)&target=fr")

    private var languagesTask: URLSessionDataTask?
    private var translateTask: URLSessionDataTask?
    private var translateSession: URLSession

    
    func getLanguages(callback: @escaping (Bool, TranslateSymbolsDataClass?) -> Void){
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
    func getTranslation(translationLanguage:String,textToTranslate: String, callback: @escaping (Bool, TranslationDataClass?) -> Void){
        guard let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2/?")  else{return}
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        let body = "key=\(ApiKeysManager.translateApiKey)&target=\(translationLanguage)&q=\(textToTranslate)&format=text&source=fr"
        request.httpBody = body.data(using: .utf8)
        
        translateTask?.cancel()
        
        translateTask = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    self.displayAlertDelegate?.showAlert(message: "data error")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    self.displayAlertDelegate?.showAlert(message: "response error")

                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslationData.self, from: data) else{
                    callback(false, nil)
                    self.displayAlertDelegate?.showAlert(message: "JSON error")
                    return
                }
                callback(true, responseJSON.data)
            }
        }
        translateTask?.resume()
    }

}
