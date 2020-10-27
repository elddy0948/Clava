//
//  UserInfoView.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

import UIKit

class UserInfoView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hojoon"
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let userNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@Holuck"
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(userNickNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = self.height / 2
        profileImageView.frame = CGRect(x: size, y: 10, width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        
        let labelSize = self.width / 2
        userNameLabel.frame = CGRect(x: size, y: profileImageView.bottom, width: labelSize, height: 30)
        userNickNameLabel.frame = CGRect(x: size, y: userNameLabel.bottom, width: labelSize, height: 30)
    }
    
}
