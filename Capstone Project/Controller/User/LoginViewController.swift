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
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loginView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // StackView Frame Settings
        loginView.frame = CGRect(x: 10, y: view.safeAreaInsets.top + view.width / 2, width: view.width - 20, height: view.width / 2)
    }
    
    //MARK: - Actions
    @objc private func didTapLogInButton() {
        print("didTapLoginButton")
    }
    @objc private func didTapSignUpButton() {
        print("didTapSignup Button")
    }
}
