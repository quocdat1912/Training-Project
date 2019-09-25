//
//  Login_Test.swift
//  Login Test
//
//  Created by Nguyen Quoc Dat on 9/25/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import XCTest
@testable import Training_Project

class Account{
    var username : String!
    var password: String!
    
    init(name : String, pass: String) {
        self.username = name
        self.password = pass
    }
}

class Login_Test: XCTestCase {
    var sut : LoginView!
    var account : [Account]!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? LoginView
        //sut = LoginView.init()
        account = [Account(name: "dat", pass: "dat123"),Account(name:"testshopify", pass: "testshopify"),Account(name: "hello", pass: "hehe")]
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        account = nil
        super.tearDown()
    }
    
    
    func testLogin() {
        var check : Bool!
        for i in 0..<account.count{
            sut.createModule()
            let promise = expectation(description: "Completion handler invoked")
            sut.loginPresenter?.loginInteratorInput?.session?.checkLogin(user: account[i].username, pass: account[i].password, handleResuilt : {(x) in
                print(x)
                check = x
                promise.fulfill()
            })
            wait(for: [promise], timeout: 25)
            if i == 0{
                XCTAssertFalse(check)
            }else{
                if i == 1{
                    XCTAssertTrue(check)
                }else{
                    XCTAssertFalse(check)
                }
            }
        }
    }
    
}

