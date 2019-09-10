//
//  MainProtocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/9/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    var presenter : MainPresenterProtocol? {get set}
    //Presenter -> View
    func displayCategory (category : [Catelogy]?)
    func displayProduct(prod:[Product]?)
    func showError()
}

protocol MainPresenterProtocol {
    var view: MainViewProtocol? {get set}
    var interactor : MainInteractorProtocol? {get set}
    //View -> Presenter
    func displayDefault()
    func displayProductByCatelogy()
    //Interactor -> Presenter
    func didGetDefault()
    func didGetProductByCatelogy()
}

protocol MainInteractorProtocol : class {
    var presenter : MainPresenterProtocol? {get set}
    var Api : ApiServiceProtocol? {get set}
    var datamanager : DataManagerProtocol? {get set}
    //Presenter -> Interactor
    func retrieveDefault()
    func retriveProductByCatelogy()
    //
    
}
protocol MainRouterProtocol {
}


