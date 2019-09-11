//
//  ProductModel.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/5/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit
import CoreData

//struct Product {
//    var id: Int
//    var name: String
//    var sku: String
//    var price: Double
//    var specialPrice: Double
//    var status: Bool
//    var urlImage: String
//    var quantity : Int
//    var page: Int
//
//}
//struct Catelogy {
//    var id: Int
//    var name: String
//    var level: Int
//    var imageURL : String
//    var page: Int
//    var products : [String]
//}
//
//class  Page  {
//    var type: String
//    var maxPage: Int
//    var currentPage: Int
//    init() {
//        type = ""
//        maxPage = 0
//        currentPage = 0
//    }
//}


//class Product: NSManagedObject {
//    @NSManaged var id: Int 
//}

class ProductModel {
        var id: String = ""
        var name: String = ""
        var sku: String = ""
        var price: String = ""
        var urlImage: String = ""
        var quantity : Int = 0
        var page: Int = 0
}

class CategoryModel {
        var id: String = ""
        var name: String = ""
        var level: Int = 0
        var imageURL : String = ""
        var page: Int = 0
        var products : [String] = []
}
