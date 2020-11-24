//
//  SettingsViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/11.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoutButton.frame = CGRect(x: 0, y: 100, width: view.width, height: 52)
    }
    
    @objc private func didTapLogoutButton() {
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.setValue(nil, forKey: "password")
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
}
