//
//  URLSessionFake.swift
//  TranslationTestCase
//
//  Created by Jordan MOREAU on 26/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// One URLSessionFake file for all tests (with or without request)

class URLSessionFake: URLSession{
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?){
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSesionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSesionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSesionDataTaskFake: URLSessionDataTask{
    var completionHandler: ((Data?, URLResponse?, Error?)-> Void)?
    
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume(){
        completionHandler?(data, urlResponse, responseError)
    }
    override func cancel(){}
}
