//
//  UserInfoView.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

import UIKit
import SDWebImage

class UserInfoView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let userNickNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
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
        
        userNameLabel.frame = CGRect(x: 0, y: profileImageView.bottom + 5,
                                     width: self.width, height: 30)
        userNickNameLabel.frame = CGRect(x: 0, y: userNameLabel.bottom,
                                         width: self.width, height: 30)
    }
    
    public func configure(with user: User?) {
        userNameLabel.text = user?.name
        userNickNameLabel.text = "@\(user?.nickname ?? "")"
        if user?.profilePhoto == "" {
            profileImageView.image = UIImage(systemName: "person.circle")
        } else {
            profileImageView.sd_setImage(with: URL(string: user?.profilePhoto ?? ""), completed: nil)
        }
    }
    
}
