//
//  TranslationService.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 15/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

final class TranslationService{
    
// One session, getLanguages (languages list) with Get method (no request) et getTranslation (use POST method request)

    
    init(translateSession: URLSession = URLSession(configuration: .default)){
        self.translateSession = translateSession
    }
    static let apiUrl = "https://translation.googleapis.com/language/translate/v2/"

    private let languagesUrl = URL(string: "\(apiUrl)languages?key=\(ApiKeysManager.translateApiKey)&target=fr")

    private var translationTask: URLSessionDataTask?
    private var translateSession: URLSession
    
    func getLanguages(callback: @escaping (Bool, TranslateSymbolsDataClass?) -> Void){
        guard let url = languagesUrl else{return}
        translationTask?.cancel()
        
        translationTask = translateSession.dataTask(with: url) { (data, response, error) in
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
        translationTask?.resume()
    }
    
    func getTranslation(translationLanguage:String,textToTranslate: String, callback: @escaping (Bool, TranslationDataClass?) -> Void){
        guard let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2/?")  else{return}
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        let body = "key=\(ApiKeysManager.translateApiKey)&target=\(translationLanguage)&q=\(textToTranslate)&format=text&source=fr"
        request.httpBody = body.data(using: .utf8)
        
        translationTask?.cancel()
        
        translationTask = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)

                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslationData.self, from: data) else{
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.data)
            }
        }
        translationTask?.resume()
    }

}
