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
            textField.backgroundColor = .red
            return textField
        }()
        
        let passwordTextField: UITextField = {
            let textField = UITextField()
            
            return textField
        }()
        emailTextField.frame = CGRect(x: 0, y: 0, width: stackView.width, height: 20)
        passwordTextField.frame = CGRect(x: 0, y: emailTextField.bottom, width: stackView.width, height: 20)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.axis = .vertical
        stackView.backgroundColor = .yellow
        stackView.distribution = .fillEqually
        
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
        textFieldStack.frame = CGRect(x: 0, y: 100, width: view.width, height: 80)
//        buttonStack.frame = CGRect(x: 0, y: textFieldStack.bottom, width: view.width, height: view.width / 2)
        
    }
}
