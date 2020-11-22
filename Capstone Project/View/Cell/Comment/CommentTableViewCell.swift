//
//  CommentTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CommentTableViewCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var userName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    private let comment: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .green
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImage)
        contentView.addSubview(userName)
        contentView.addSubview(comment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Profile Image
        profileImage.frame = CGRect(x: 0, y: 0, width: contentView.height, height: contentView.height)
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = contentView.height / 2
        
        //User Name
        userName.frame = CGRect(x: profileImage.right + 4, y: 0, width: 100, height: contentView.height)
        
        //Comment
        comment.frame = CGRect(x: userName.right + 4, y: 0,
                               width: (contentView.width - profileImage.width - userName.width - 12), height: contentView.height)
    }
}
