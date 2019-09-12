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

struct ProductModel: Codable {
        var id: String!
        var name: String!
        var sku: String!
        var price: String!
        var imageUrl: String!
        var quantity : Int!
        var page: Int!
    
    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? map.decode(String.self, forKey: CodingKeys.id)) ?? ""
        self.name = (try? map.decode(String.self, forKey: CodingKeys.name)) ?? ""
        self.sku = (try? map.decode(String.self, forKey: CodingKeys.sku)) ?? ""
        self.price = (try? map.decode(String.self, forKey: CodingKeys.price)) ?? ""
        self.imageUrl = (try? map.decode(String.self, forKey: CodingKeys.imageUrl)) ?? ""
        self.quantity = (try? map.decode(Int.self, forKey: CodingKeys.quantity)) ?? 0
        self.page = (try? map.decode(Int.self, forKey: CodingKeys.page)) ?? 0
    }
    enum CodingKeys: CodingKey {
        case id
        case name
        case sku
        case price
        case imageUrl
        case quantity
        case page
    }
    
}
struct CategoryModel : Codable {
    var id : String!
    var name : String!
    var level : Int!
    var imageUrl : String!
    var productIds: [String]!
    var page: Int!
    
    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? map.decode(String.self, forKey: CodingKeys.id)) ?? ""
        self.name = (try? map.decode(String.self, forKey: CodingKeys.name)) ?? ""
        self.level = (try? map.decode(Int.self, forKey: CodingKeys.level)) ?? 0
        self.imageUrl = (try? map.decode(String.self, forKey: CodingKeys.imageUrl)) ?? ""
        self.productIds = (try? map.decode([String].self, forKey: CodingKeys.productIds)) ?? []
        self.page = (try? map.decode(Int.self, forKey: CodingKeys.page)) ?? 0
    }
    private enum CodingKeys: CodingKey {
        case id
        case name
        case level
        case imageUrl
        case productIds
        case page
    }

}


