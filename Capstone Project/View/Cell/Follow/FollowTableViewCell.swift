//
//  FollowTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/20.
//

import UIKit

class FollowTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FollowTableViewCell"
    
    private var model: BetweenUserCircle?
    
    //MARK: - Views
    private let circlePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let circleName: UILabel = {
        let label = UILabel()
        label.text = "holuck"
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(circlePhoto)
        contentView.addSubview(circleName)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        circlePhoto.frame = CGRect(x: 16, y: 2, width: size, height: size)
        circlePhoto.layer.masksToBounds = true
        circlePhoto.layer.cornerRadius = size / 2
        
        circleName.frame = CGRect(x: circlePhoto.right + 4, y: 2, width: contentView.width - circlePhoto.width - 8, height: size)
    }
    
    //MARK: - public
    public func configure(with model: BetweenUserCircle) {
    }
}
