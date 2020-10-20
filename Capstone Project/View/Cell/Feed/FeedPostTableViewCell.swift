//
//  FeedPostTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

/*
 - Post Image
 */

class FeedPostTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedPostTableViewCell"
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.masksToBounds = true
        contentView.addSubview(postImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImage.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.width)
    }

    public func configure(model: String) {
        
    }
}
