//
//  APIservice.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

typealias CompletionHandler = ((_ data: Data?, _ error: String?) -> Void)

class ApiService {
    var token : String?
    func requestLogin (account: String, pass: String, completeHandler : () -> Void) {
        let url = URL(string: "https://api.unityspace.space/login")!
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        //set method request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //Post data
        let postPara : [String: String] = ["username": "\(account)",
                                        "password" : "\(pass)" ]
        guard let postData = try? JSONSerialization.data(withJSONObject: postPara, options: []) else {return}
        request.httpBody = postData
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard error == nil else {return}
            guard let token = data else {return}
            print(token)
            self.token = String(data: token, encoding: .utf8)
            
        }
    }
    
    // -----------------
    
    
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
        if let url = urlResponse?.url?.absoluteString, let closure = dictionaryCompletionHandler[url] {
            closure(data, error?.localizedDescription)
        }
        
    }
    
}

