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
            
            return textField
        }()
        
        let passwordTextField: UITextField = {
            let textField = UITextField()
            
            return textField
        }()
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
