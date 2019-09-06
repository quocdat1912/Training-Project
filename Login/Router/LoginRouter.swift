//
//  LoginRouter.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/6/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class LoginRouter:LoginRouterProtocol {
    static func createLoginModule (view: LoginView) {
        let presenter: LoginPresengerProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let session: SessionProtocol = Session()
        let router : LoginRouterProtocol = LoginRouter()
        let apiService: ApiServiceProtocol = ApiService()
        
        view.loginPresenter = presenter
        presenter.loginInteratorInput = interactor
        presenter.loginView = view
        presenter.loginRouter = router
        interactor.loginPresenter = presenter
        interactor.session = session
        session.loginInteractor = interactor
        session.apiService = apiService
        
    }
    
    
}
