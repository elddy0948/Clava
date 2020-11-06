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
    private let textFieldView = LoginSignupView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(textFieldView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // StackView Frame Settings
        textFieldView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 120)
    }
    
    //MARK: - Actions
    @objc private func didTapLogInButton() {
        print("didTapLoginButton")
    }
    @objc private func didTapSignUpButton() {
        print("didTapSignup Button")
    }
}
