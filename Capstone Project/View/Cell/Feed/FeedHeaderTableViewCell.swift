//
//  FeedHeaderTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

/*
 
 - Profile Image  /  Profile Name  / More
 
 */

protocol FeedHeaderTableViewCellDelegate: AnyObject {
    func pressProfileName()
}

class FeedHeaderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedHeaderTableViewCell"
        
    weak var delegate: FeedHeaderTableViewCellDelegate?
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let profileName: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .none
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.addSubview(profileImage)
        contentView.addSubview(profileName)
        contentView.addSubview(moreButton)
        
        //MARK: - Add Target
        profileName.addTarget(self, action: #selector(pressProfileName), for: .touchUpInside)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height - 4
        profileImage.frame = CGRect(x: 2, y: 4,
                                    width: imageSize - 4, height: imageSize - 4)
        profileImage.layer.cornerRadius = (imageSize - 4) / 2
        
        profileName.frame = CGRect(x: profileImage.right + 4, y: 2,
                                   width: contentView.width - 16 - (imageSize * 2), height: imageSize)
        
        moreButton.frame = CGRect(x: contentView.width - imageSize, y: 2,
                                  width: imageSize, height: imageSize)
    }
    
    
    //MARK: - public
    public func configure(model: Circle) {
        profileName.setTitle(model.name, for: .normal)
    }
    
    //MARK: - Actions
    @objc private func pressProfileName() {
        delegate?.pressProfileName()
    }
}
