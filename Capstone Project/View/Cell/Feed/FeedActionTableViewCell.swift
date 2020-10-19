//
//  FeedActionTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

class FeedActionTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FeedActionTableViewCell"
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        likeButton.frame = CGRect(x: 2, y: 2, width: size, height: size)
        commentButton.frame = CGRect(x: likeButton.right, y: 2, width: size, height: size)
    }
}
