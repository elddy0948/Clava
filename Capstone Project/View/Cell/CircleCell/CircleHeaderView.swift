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
    func didTapsignOutCircleButton()
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
    
    private let signOutCircleButton: UIButton = {
       let button = UIButton()
        button.setTitle("탈퇴하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .link
        button.addTarget(self, action: #selector(didTapsignOutCircleButton), for: .touchUpInside)
        return button
    }()
    
    private let circleDescription: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 17)
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
        self.addSubview(signOutCircleButton)
        signOutCircleButton.isHidden = true
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
        let subviewsHeight: CGFloat = 30
        circleBelong.frame = CGRect(x: 0, y: heightFromImage, width: labelSize, height: subviewsHeight)
        circleArea.frame = CGRect(x: circleBelong.right, y: heightFromImage, width: labelSize, height: subviewsHeight)
        circleCategory.frame = CGRect(x: circleArea.right, y: heightFromImage, width: labelSize, height: subviewsHeight)
        
        let buttonWidth = self.width / 2 - 16
        let heightFromLabel = circleBelong.bottom + 8
        followButton.frame = CGRect(x: 8, y: heightFromLabel, width: buttonWidth, height: subviewsHeight)
        registerButton.frame = CGRect(x: followButton.right + 8, y: heightFromLabel, width: buttonWidth, height: subviewsHeight)
        followButton.layer.masksToBounds = true
        registerButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 8
        registerButton.layer.cornerRadius = 8
        followButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        signOutCircleButton.frame = CGRect(x: 8, y: heightFromLabel, width: (buttonWidth) * 2, height: subviewsHeight)
        signOutCircleButton.layer.masksToBounds = true
        signOutCircleButton.layer.cornerRadius = 8
        signOutCircleButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        circleDescription.frame = CGRect(x: 0, y: followButton.bottom + 8,
                                         width: self.width, height: self.height - circleImageView.height - 96)
    }
    
    public func configure(with model: Circle?) {
        circleImageView.sd_setImage(with: URL(string: "\(model?.circleProfilePhoto ?? "")"), completed: nil)
        circleArea.text = model?.place
        circleBelong.text = model?.organization
        circleCategory.text = model?.category
        circleDescription.text = model?.descriptionField
    }
    public func buttonHidden(followButton: Bool, registerButton: Bool, signOutButton: Bool) {
        self.followButton.isHidden = followButton
        self.registerButton.isHidden = registerButton
        self.signOutCircleButton.isHidden = signOutButton
    }
    
    //MARK: - Button Actions
    @objc private func didTapFollowButton() {
        delegate?.didTapFollowButton()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.didTapRegisterButton()
    }
    
    @objc private func didTapsignOutCircleButton() {
        delegate?.didTapsignOutCircleButton()
    }
}
