//
//  CircleHeaderView.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/30.
//

import UIKit
import SDWebImage

protocol CircleHeaderViewDelegate: AnyObject {
    func didTapFollowButton()
    func didTapRegisterButton()
}

class CircleHeaderView: UIView {
    
    /*
     -  Header
        - 동아리 이미지
        - 소속  / 위치  / 카테고리
        - 팔로우하기 버튼 / 가입하기 버튼
        - 설명
     */
    
    public var circleModel: Circle?
    weak var delegate: CircleHeaderViewDelegate?
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let circleBelong: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let circleArea: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let circleCategory: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: - Button View
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .link
        button.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .link
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private let circleDescription: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.text = "설명이 없어요 ㅠ..ㅠ"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        self.addSubview(circleImageView)
        self.addSubview(circleArea)
        self.addSubview(circleBelong)
        self.addSubview(circleCategory)
        self.addSubview(circleDescription)
        self.addSubview(followButton)
        self.addSubview(registerButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = self.width / 3
        circleImageView.frame = CGRect(x: size, y: 10, width: size, height: size)
        circleImageView.layer.cornerRadius = size / 2
        
        let labelSize = self.width / 3
        let heightFromImage = circleImageView.bottom + 8
        circleBelong.frame = CGRect(x: 0, y: heightFromImage, width: labelSize, height: 30)
        circleArea.frame = CGRect(x: circleBelong.right, y: heightFromImage, width: labelSize, height: 30)
        circleCategory.frame = CGRect(x: circleArea.right, y: heightFromImage, width: labelSize, height: 30)
        
        let buttonWidth = self.width / 2 - 16
        let heightFromLabel = circleBelong.bottom + 8
        followButton.frame = CGRect(x: 8, y: heightFromLabel, width: buttonWidth, height: 30)
        registerButton.frame = CGRect(x: followButton.right + 8, y: heightFromLabel, width: buttonWidth, height: 30)
        followButton.layer.masksToBounds = true
        registerButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 8
        registerButton.layer.cornerRadius = 8
        followButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        circleDescription.frame = CGRect(x: 0, y: followButton.bottom + 8, width: self.width, height: self.height - circleImageView.height - 94)

    }
    
    public func configure(with model: Circle?) {
        circleImageView.sd_setImage(with: URL(string: "\(model?.circleProfilePhoto ?? "")"), completed: nil)
        circleArea.text = model?.name
        circleBelong.text = model?.organization
        circleCategory.text = model?.category
        circleDescription.text = model?.descriptionField
    }
    public func dismissFollowButton() {
        self.followButton.isHidden = true
    }
    public func dismissRegisterButton() {
        self.followButton.isHidden = true
        self.registerButton.isHidden = true
    }
    
    //MARK: - Button Actions
    @objc private func didTapFollowButton() {
        delegate?.didTapFollowButton()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.didTapRegisterButton()
    }
}
