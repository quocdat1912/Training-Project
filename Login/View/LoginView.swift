//
//  LoginView.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/4/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTap(_ sender: Any) {
        
    }
    
    func setUI ()  {
        userNameTextField.layer.cornerRadius = 3
        passWordTextField.layer.cornerRadius = 3
        loginButton.layer.cornerRadius = 4
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y: userNameTextField.frame.height - 10), size: CGSize(width: userNameTextField.frame.width, height: 1))
        bottomLine.backgroundColor = UIColor.gray.cgColor
        userNameTextField.borderStyle = UITextField.BorderStyle.none
        passWordTextField.borderStyle = UITextField.BorderStyle.none
        userNameTextField.layer.addSublayer(bottomLine)
        passWordTextField.layer.addSublayer(bottomLine)
    }

}
