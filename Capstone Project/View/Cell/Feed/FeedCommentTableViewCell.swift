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
        
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
