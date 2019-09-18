//
//  MainProtocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/9/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation
import UIKit
protocol MainViewProtocol: class {
    var presenter : MainPresenterProtocol? {get set}
    //Presenter -> View
    func displayCategory (categories: [CategoryModel])
    func displayProduct(products:[ProductModel])
    func showError()
}

protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? {get set}
    var interactor : MainInteractorProtocol? {get set}
    //View -> Presenter
    func displayDefault()
    func displayProductByCatelogy()
    //static func saveImage(urlString: String, completion: @escaping (UIImage?) -> Void)
    //Interactor -> Presenter
    func didGetProducts(products:[Product])
    func didGetCategories(categories:[Category])
}
    protocol MainInteractorProtocol : class {
    var presenter : MainPresenterProtocol? {get set}
    var Api : ApiServiceProtocol? {get set}
    var datamanager : DataManagerProtocol? {get set}
    
    //Presenter -> Interactor
    func retrieveData()
    func deleteDataBase()

}
protocol MainRouterProtocol {
    static func createMainModule(view : MainViewController)
}


