//
//  Protocol.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

protocol SessionProtocol: class {
    //LoginInteractor -> Session
    func checkSession() -> Bool
    //APIservice -> Session
    func saveSession()
    
}
