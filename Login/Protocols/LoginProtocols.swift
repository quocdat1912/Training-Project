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
}

protocol LoginPresengerProtocol: class {
    var loginView : LoginViewProtocol? {get set}
    var loginRouter: LoginRouterProtocol? {get set}
    var loginInteratorInput : LoginInteractorInputProtocol? {get set}
    
    
}

protocol LoginInteractorOutProtocol: class {
    
    
}
protocol LoginInteractorInputProtocol: class {
    
}
protocol LoginRouterProtocol: class {
    
}
