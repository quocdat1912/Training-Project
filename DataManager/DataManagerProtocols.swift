//
//  Protocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/10/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation
import CoreData

typealias DataHandler = ([NSManagedObject]?) -> Void

protocol DataManagerProtocol: class{
    //Interactor -> Datamanager
    func fetchProduct (handler: DataHandler ) throws
    func fetchCategory(handler: DataHandler) throws
    func saveProduct(products: [ProductModel], handler: DataHandler) throws
    func saveCategory(categories: [CategoryModel],handler: DataHandler) throws
    func savePage(type:String, maxPage:Int, currentPage: Int, handler: DataHandler) throws
    func updatePage(page : Page ,handLer: DataHandler) throws
    func fetchPage(handler : DataHandler) throws
    
}
