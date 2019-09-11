//
//  PersistenceError.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/11/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

enum PersistenceError : Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
    case couldNotFetch
}
