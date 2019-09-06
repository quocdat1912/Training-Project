//
//  Protocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol: class {
    //Session -> APIservice
    func post (urlString: String, data: [String: Any], completeHandler:@escaping CompletionHandler)
}
