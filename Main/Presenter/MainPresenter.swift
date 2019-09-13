//
//  MainPresenter.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/11/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var products : [ProductModel] = []
    var categories : [CategoryModel] = []
    
    
    func displayDefault() {
        interactor?.retrieveData()
        //interactor?.deleteDataBase()
    }
    
    func displayProductByCatelogy() {
        
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
    }

    
    
}
