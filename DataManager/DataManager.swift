//
//  DataManager.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/10/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation
import CoreData

class DataManager: DataManagerProtocol {

    func saveProduct(products: [ProductModel], handler: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext) else {
            throw PersistenceError.couldNotSaveObject
            
        }
        for product in products {
            let pro = Product(entity: entity, insertInto: managedContext)
            pro.id = product.id
            pro.image_url = product.imageUrl
            pro.name = product.name
            pro.page = Int16(product.page)
            pro.price = product.price
            pro.quantity = Int64(product.quantity)
            pro.sku = product.sku
            
            try managedContext.save()
        }
       
    }
    
    func saveCategory(categories: [CategoryModel], handler: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext) else {
            throw PersistenceError.couldNotSaveObject
        }
        for category in categories {
            let cate = Category(entity: entity, insertInto: managedContext)
            cate.id = category.id
            cate.image_url = category.imageUrl
            cate.level = Int16(category.level)
            cate.name = category.name
            cate.page = Int16(category.page)
            cate.products = category.productIds
            try managedContext.save()
        }
    }
    
    func savePage(type:String, maxPage:Int, currentPage: Int, handler: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Page", in: managedContext) else {
            throw PersistenceError.couldNotSaveObject
        }
            let page = Page(entity: entity, insertInto: managedContext)
            page.type = type
            page.max_page = Int16(maxPage)
            page.current_page = Int16(currentPage)
            
            try managedContext.save()
        }

    
    func fetchProduct(handler: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
        do {
            let products : [Product] = try managedContext.fetch(fetchRequest) as! [Product]
            handler(products)
        }catch {
            throw PersistenceError.couldNotFetch
        }
    }
    
    func fetchCategory(handler: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        do {
            let categores : [Category] = try managedContext.fetch(fetchRequest) as! [Category]
            handler(categores)
        }catch {
            throw PersistenceError.couldNotFetch
        }
    }
    
    
    
    func updatePage(page: Page, handLer: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                print("Save successfully")
            } catch{
                throw PersistenceError.couldNotSaveObject
            }
        }
    }
    
    func fetchPage(handler: ([NSManagedObject]?) -> Void) throws {
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Page")
        do {
            let pages : [Page] = try managedContext.fetch(fetchRequest) as! [Page]
            handler(pages)
        }catch {
            throw PersistenceError.couldNotFetch
        }
    }
    
    func deleteAllData(entityName: String){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        let managedContext = AppDelegate.shared.persistentContainer.viewContext
        do{
            try managedContext.execute(request)
        }catch{
            print(error.localizedDescription)
        }
    }
}
