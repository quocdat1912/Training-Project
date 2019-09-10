//
//  ProductModel.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

struct Product {
    var id: Int
    var name: String
    var sku: String
    var price: Double
    var specialPrice: Double
    var status: Bool
    var urlImage: String
    var quantity : Int
    var page: Int
    
}
struct Catelogy {
    var id: Int
    var name: String
    var level: Int
    var imageURL : String
    var page: Int
    var products : [String]
}

struct Page {
    var type: String
    var maxPage: Int
    var currentPage: Int
}
