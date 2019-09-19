//
//  MainPresenter.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/11/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: MainPresenterProtocol {
 
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var products : [ProductModel] = []
    var categories : [CategoryModel] = []
    
    
    func displayDefault() {
        interactor?.retrieveData()
//        interactor?.deleteDataBase()
    }
    
    func displayProductByCatelogy(senderTag: Int) {
        let string = categories[senderTag].productIds
        var productArray : [ProductModel] = []
        for id in string!{
            for product in products{
                if(product.id == id){
                    productArray.append(product)
                }
            }
        }
        view?.displayProduct(products: productArray)
    }
    
    func didGetProducts(products: [Product]) {
        for product in products{
            var productModel = ProductModel()
            productModel.id = product.id
            productModel.imageUrl = product.image_url
            productModel.name = product.name
            productModel.page = Int(product.page)
            productModel.price = product.price
            productModel.quantity = Int(product.quantity)
            productModel.sku = product.sku
            
            self.products.append(productModel)
        }
        print("Number of products: \(self.products.count)")
        view?.displayProduct(products: self.products)
    }
    
    func didGetCategories(categories: [Category]) {
        for category in categories{
            var categoryModel = CategoryModel()
            categoryModel.id = category.id
            categoryModel.name = category.name
            categoryModel.imageUrl = category.image_url
            categoryModel.level = Int(category.level)
            categoryModel.page = Int(category.page)
            categoryModel.productIds = category.products
            
            self.categories.append(categoryModel)
        }
        print("Number of categories: \(self.categories.count)")
        view?.displayCategory(categories: self.categories)
    }
    func getProducts() -> [ProductModel] {
        return self.products
    }
    func getCategories() -> [CategoryModel] {
        return self.categories
    }
    
    
    
    
//    static func saveImage(urlString: String, completion: @escaping (UIImage?) -> Void){
//        let string64 = urlString.base64Encoded()!
//        ApiService.downloadingData(urlString: urlString) { (data, error) in
//            guard  error == nil else {
//                print("Couldn't find image")
//                return
//            }
//            if DataManager.createDirectory(pathString: "images"){
//                DataManager.saveImageToDirectory(pathDirectory: "images", nameFile: string64, image: UIImage(data: data!)!)
//            }else{
//                DataManager.saveImageToDirectory(pathDirectory: "images", nameFile: string64, image: UIImage(data: data!)!)
//            }
//            completion(UIImage(data: data!))
//        }
//        
//    }
    
    
    
}
