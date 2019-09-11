//
//  MainInteractor.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/11/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class MainInteractor : MainInteractorProtocol {
    var presenter: MainPresenterProtocol?
    
    var Api: ApiServiceProtocol?
    
    var datamanager: DataManagerProtocol?
    
    func retrieveData() {
        do {
            try datamanager?.fetchProduct(handler: { (nsmanagedobject) in
                print(nsmanagedobject!)
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}
