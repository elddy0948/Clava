//
//  LoginViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/01.
//

import UIKit

/*
 - email
 - password
 - login button
 - signup button
 */

class LoginViewController: UIViewController {
    
    private let textFieldStack: UIStackView = {
        let stackView = UIStackView()
        
        let emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "EMAIL"
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 8
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
            return textField
        }()
        
        let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "PASSWORD"
            textField.isSecureTextEntry = true
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 8
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
            return textField
        }()
        
        emailTextField.frame = CGRect(x: 0, y: 0, width: stackView.width, height: 52)
        passwordTextField.frame = CGRect(x: 0, y: emailTextField.bottom, width: stackView.width, height: 52)

        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let buttonStack: UIStackView = {
        let stackView = UIStackView()
        
        //Button Views
        let loginButton: UIButton = {
            let button = UIButton()
            
            return button
        }()
        
        let signupButton: UIButton = {
            let button = UIButton()
            return button
        }()
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(textFieldStack)
//        view.addSubview(buttonStack)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textFieldStack.frame = CGRect(x: 10, y: view.height / 2, width: view.width - 20, height: 120)
//        buttonStack.frame = CGRect(x: 0, y: textFieldStack.bottom, width: view.width, height: view.width / 2)
        
    }
}
