//
//  FeedCommentTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

class FeedCommentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FeedCommentTableViewCell"
    
    private let userName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "holuck"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let comments: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Good Post!"
        label.textColor = .label
        return label
    }()
    
    private let moreCommentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.setTitle("Show Comment", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userName)
        contentView.addSubview(comments)
        contentView.addSubview(moreCommentButton)
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userName.frame = CGRect(x: 8, y: 10, width: contentView.width / 4, height: contentView.height / 4)
        comments.frame = CGRect(x: userName.right + 4, y: 10, width: contentView.width - userName.width, height: contentView.height / 4)
        moreCommentButton.frame = CGRect(x: 0, y: contentView.height - 24, width: contentView.width / 3, height: comments.height)
    }
}
