//
//  Interactor.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/6/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    
    var session: SessionProtocol?
    weak var loginPresenter: LoginPresengerProtocol?
    
    func loginSuccess() {
        loginPresenter?.didLoginSuccess()
    }
    func loginFail(errorString: String) {
        loginPresenter?.didLoginFail(errorString: errorString)
    }
    func loginInput(user: String, pass: String) {
        session?.checkLogin(user: user, pass: pass)
    }
    
}
