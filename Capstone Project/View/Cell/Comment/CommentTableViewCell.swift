//
//  CommentTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CommentTableViewCell"
    
    private var userName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let comment: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 15)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userName)
        contentView.addSubview(comment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //User Name
        userName.frame = CGRect(x: 4, y: 2, width: 100, height: 30)
        
        //Comment
        comment.frame = CGRect(x: userName.right + 4, y: 0,
                               width: (contentView.width - userName.width - 12), height: contentView.height)
    }
    public func configure(with comment: Comment) {
        userName.text = comment.author
        self.comment.text = comment.descriptionField
    }
}
