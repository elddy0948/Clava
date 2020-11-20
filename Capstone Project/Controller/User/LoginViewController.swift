//
//  LoginViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/01.
//

import UIKit
import Alamofire

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
        loginView.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(loginView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // StackView Frame Settings
        loginView.frame = CGRect(x: 10, y: view.safeAreaInsets.top + view.width / 2, width: view.width - 20, height: view.width / 2)
    }
}
extension LoginViewController: LoginViewDelegate {
    func didTapLoginButton() {
        guard let email = loginView.emailTextField.text else { fatalError("Email Error") }
        guard let password = loginView.passwordTextField.text else { fatalError("Password Error") }
        let parameter: Parameters = [
            "email": "\(email)",
            "password": "\(password)"
        ]
        let url: String = "http://3.35.240.252:8080/auth"
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default,
                   headers: [
                    "Content-Type": "application/json"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        print(data)
                        UserDefaults.standard.set("\(email)", forKey: "email")
                        UserDefaults.standard.set("\(password)", forKey: "password")
                        self.dismiss(animated: true, completion: nil)
                    }
        }
    }
    func didTapSignupButton() {
        print("SignUp")
    }
}
