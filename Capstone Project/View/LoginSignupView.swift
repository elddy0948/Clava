//
//  LoginSignupView.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/05.
//

import UIKit

class LoginSignupView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    //Text Field Views
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " EMAIL"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " PASSWORD"
        textField.isSecureTextEntry = true
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    //Button Views
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signupButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        emailTextField.frame = CGRect(x: 0, y: 0, width: stackView.width, height: 52)
        passwordTextField.frame = CGRect(x: 0, y: emailTextField.bottom, width: stackView.width, height: 52)
    }
    
    //MARK: - Actions
    @objc private func didTapLogInButton() {
        
    }
    @objc private func didTapSignUpButton() {
        
    }
}
