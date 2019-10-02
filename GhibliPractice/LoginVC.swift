//
//  LoginVC.swift
//  GhibliPractice
//
//  Created by C4Q on 10/1/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    private let myEmail = "IramFattah94@gmail.com"
    private let myPassword = "6.1rocks"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldsFromUserDefaults()

        // Do any additional setup after loading the view.
    }
    
    private func setupTextFieldsFromUserDefaults() {
        let emailAndPass = UserDefaultsWrapper.shared.getEmailAndPassword()
        guard let email = emailAndPass.email else {
            return
        }
        guard let password = emailAndPass.pass else {
            return
        }
        emailTextField.text = email
        passwordTextField.text = password
        
         loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        
    }
    
    
    private func setupUI() {
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        emailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
          loginButton.layer.cornerRadius = 5
         loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
       
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Invalid Login", message: "Incorrect email and/or password", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func formValidation() {
        guard emailTextField.hasText, passwordTextField.hasText else {
             loginButton.isEnabled = false
              loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
             return}
         loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
         
    }
    
    
    @objc func handleLogin() {
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text else {return}
            
        guard email == myEmail.lowercased(), password == myPassword else {
            showAlert()
            return
        }
        UserDefaultsWrapper.shared.storeEmailAndPassword(email: email, password: password)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainTab = storyBoard.instantiateViewController(identifier: "MainTabBar")
        present(mainTab, animated: true, completion: nil)
    
        
        
    }

  

}