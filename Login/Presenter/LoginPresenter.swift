//
//  LoginPresenter.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/6/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresengerProtocol {
    
    
    
    weak var loginView: LoginViewProtocol?
    
    var loginRouter: LoginRouterProtocol?
    
    var loginInteratorInput: LoginInteractorInputProtocol?
    
    func didLoginSuccess() {
        loginView?.hideLoading()
        //loginView?.showSuccess()
    }
    func didLoginFail(errorString : String) {
        loginView?.hideLoading()
        loginView?.showError(erroString: errorString)
    }
    func loginOnTap(user: String, pass: String) {
        loginInteratorInput?.loginInput(user: user, pass: pass)
        loginView?.showLoading()
    }
    func showMainController() {
        loginRouter?.presentMainViewController()
    }
}
