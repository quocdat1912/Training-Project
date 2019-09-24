//
//  Session.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/6/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class Session : SessionProtocol {
    var apiService: ApiServiceProtocol?
    
    var loginInteractor: LoginInteractorInputProtocol?
    
    func checkLogin(user: String?, pass: String?) {
        let account = ["username": user!,
                    "password": pass!]
        apiService?.post(urlString: "https://api.unityspace.space/login", data: account) { (data, error) in
            guard  error == nil else {
                self.loginInteractor?.loginFail(errorString: error!)
                return}
            let string = String(data: data!, encoding: .utf8)
            //check JWT
            let stringComponent:[String] = (string?.components(separatedBy: "."))!
            guard stringComponent.count == 3  else {
                self.loginInteractor?.loginFail(errorString: "Not found account or password")
                return}
            let trueString = string?.replacingOccurrences(of: "\"", with: "")
            print(string!)
            self.loginInteractor?.loginSuccess()
            self.saveUser(data: trueString!)
        }
    } 

    func saveUser(data: String){
        UserDefaults.standard.set(data, forKey: "token")
    }
    
}
