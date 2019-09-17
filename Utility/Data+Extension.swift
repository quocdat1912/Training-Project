//
//  Data+Extension.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

extension Data {
    func toDictionary() -> [String: Any]? {
        return [:]
    }
}

extension String{

    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    

    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
