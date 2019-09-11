//
//  Router.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/11/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class MainRouter : MainRouterProtocol{
    static func createMainModule(view: MainViewController) {
        let presenter : MainPresenterProtocol = MainPresenter()
        let interactor: MainInteractorProtocol = MainInteractor()
        let api : ApiServiceProtocol = ApiService()
        let datamanager : DataManagerProtocol = DataManager()
        //let router : MainRouterProtocol = MainRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.Api = api
        interactor.datamanager = datamanager
        interactor.presenter = presenter
        
    }
    
}
