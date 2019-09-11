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
    
    func displayDefault() {
        interactor?.retrieveData()
    }
    
    func displayProductByCatelogy() {
        
    }
    
    func didGetData() {
        
    }
    

    
    
}
