//
//  APIservice.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

typealias CompletionHandler = ((_ data: Data?, _ error: String?) -> Void)

class ApiService:ApiServiceProtocol {
    
    var dictionaryCompletionHandler: [String: CompletionHandler] = [:]
    
    func post (urlString: String, data: [String: Any], completeHandler:@escaping CompletionHandler) {
        guard let url = URL(string: urlString) else {
            completeHandler(nil, "Url not found")
            return
        }
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        //set method request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Save completeHandler
        dictionaryCompletionHandler[urlString] = completeHandler
        
        //Post data
        guard let postData = try? JSONSerialization.data(withJSONObject: data, options: []) else {return}
        request.httpBody = postData
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            self.handleResponse(data: data, urlResponse: response, error: error)
        }
        task.resume()
        

    }
    
    func handleResponse(data: Data?, urlResponse: URLResponse?, error: Error?) {
        // handle
        print(Thread.current.description)
        if let url = urlResponse?.url?.absoluteString, let closure = dictionaryCompletionHandler[url] {
            DispatchQueue.main.async {
                closure(data, error?.localizedDescription)
            }
        }
        
    }
    func get(urlString : String, token: String, completeHandler: @escaping CompletionHandler) {
        
        guard let url = URL(string: urlString) else {
            completeHandler(nil,"Url not found")
            return
        }
        let urlSession = URLSession(configuration: .default)
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        getRequest.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        //Save completeHandle
        dictionaryCompletionHandler[urlString] = completeHandler
        
        //Get Data
        let task = urlSession.dataTask(with: getRequest) { (data, response, error) in
            self.handleResponse(data: data, urlResponse: response, error: error)
        }
        task.resume() 
        
    }
    
    
    
}

