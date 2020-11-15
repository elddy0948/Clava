//
//  ExploreTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/16.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ExploreTableViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let circleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        addSubview(circleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 0, y: 0, width: self.height, height: self.height)
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = self.height / 2
        circleLabel.frame = CGRect(x: profileImageView.right + 10, y: 0, width: self.width - profileImageView.width, height: self.height)
    }
    
    public func configure(with model: Circle) {
        circleLabel.text = model.name
        
    }
}
