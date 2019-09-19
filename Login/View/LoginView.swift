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
    var loginPresenter: LoginPresengerProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginRouter.createLoginModule(view: self)
        setUI()
        //UserDefaults.standard.removeObject(forKey: "token")
        
    }
    override func viewWillAppear(_ animated: Bool) {
  
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let token = UserDefaults.standard.value(forKey: "token") else {
            return
        }
        //print(token)
        showSuccess()
    }
    

    @IBAction func loginTap(_ sender: Any) {
        guard let username = userNameTextField.text, let pass = passWordTextField.text else{return}
        loginPresenter?.loginOnTap(user: username, pass: pass)
    }
    
    func setUI ()  {
        userNameTextField.layer.cornerRadius = 3
        passWordTextField.layer.cornerRadius = 3
        loginButton.layer.cornerRadius = 4
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y: userNameTextField.frame.height - 10), size: CGSize(width: userNameTextField.frame.width, height: 1))
        bottomLine.backgroundColor = UIColor.gray.cgColor
        let bottomLine2 = CALayer()
        
        bottomLine2.frame = CGRect(origin: CGPoint(x: 0, y: userNameTextField.frame.height - 10), size: CGSize(width: userNameTextField.frame.width, height: 1))
        bottomLine2.backgroundColor = UIColor.gray.cgColor
        userNameTextField.borderStyle = UITextField.BorderStyle.none
        passWordTextField.borderStyle = UITextField.BorderStyle.none
        userNameTextField.layer.addSublayer(bottomLine)
        passWordTextField.layer.addSublayer(bottomLine2)
        passWordTextField.isSecureTextEntry = true
        userNameTextField.text = "testshopify"
        passWordTextField.text = "testshopify"
    }
    func showAlert(titleString : String){
        let alertController = UIAlertController(title: "Thông báo", message: titleString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
extension LoginView : LoginViewProtocol {
    func showError(erroString: String) {
        showAlert(titleString: erroString)
        
    }
    
    
    func showSuccess() {
        //showAlert(titleString: "LoginSuccess")
        performSegue(withIdentifier: "mainSegue", sender: nil)
    }
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait..", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoading() {
        dismiss(animated: false, completion: nil)
    }
  
}
