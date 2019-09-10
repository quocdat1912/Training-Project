//
//  LoginProtocols.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/4/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

protocol LoginViewProtocol : class {
    var loginPresenter : LoginPresengerProtocol? {get set}
    //Presntor -> View
    func showError(erroString: String)
    func showSuccess()
    func showLoading()
    func hideLoading()
}

protocol LoginPresengerProtocol: class {
    var loginView : LoginViewProtocol? {get set}
    var loginRouter: LoginRouterProtocol? {get set}
    var loginInteratorInput : LoginInteractorInputProtocol? {get set}
    //Interactor -> Presenter
    func didLoginSuccess()
    func didLoginFail(errorString : String)
    //View -> presenter
    func loginOnTap(user: String, pass: String)
    
}

protocol LoginInteractorOutProtocol: class {
    var loginPresenter : LoginPresengerProtocol? {get set}
    
}
protocol LoginInteractorInputProtocol: class {
    var session: SessionProtocol? {get set}
    var loginPresenter: LoginPresengerProtocol? {get set}
    //Sesion -> LoginInteractor
    func loginSuccess()
    func loginFail(errorString : String)
    //Presenter -> Interactor
    func loginInput (user: String, pass: String)
}
protocol LoginRouterProtocol: class {
    static func createLoginModule(view: LoginView)
    
}
