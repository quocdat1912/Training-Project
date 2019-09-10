//
//  Protocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/10/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

protocol DataManagerProtocol: class{
    func fetchProduct ()
    func fetchCatelogy()
    func saveProduct()
    func saveCatelogy()
    func savePage()
    func updatePage()
    func fetchPage()
}
