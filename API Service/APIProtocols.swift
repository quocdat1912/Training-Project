//
//  Protocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol: class {
    //Session, MainInteractor -> APIservice
    func post (urlString: String, data: [String: Any], completeHandler:@escaping CompletionHandler)
    func get(urlString : String, token: String, completeHandler: @escaping CompletionHandler)
    static func downloadingData (urlString: String, completeHandler: @escaping CompletionHandler)
}
