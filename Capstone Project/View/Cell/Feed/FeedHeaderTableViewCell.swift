//
//  FeedHeaderTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit
import SDWebImage

/*
 
 - Profile Image  /  Profile Name  / More
 
 */

protocol FeedHeaderTableViewCellDelegate: AnyObject {
    func pressProfileName(goto circle: Circle?)
    func pressMoreButton(with post: Post?)
}

class FeedHeaderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedHeaderTableViewCell"
    private var circle: Circle?
    private var post: Post?
        
    weak var delegate: FeedHeaderTableViewCellDelegate?
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
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
        moreButton.addTarget(self, action: #selector(pressMoreButton), for: .touchUpInside)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        profileName.setTitle(nil, for: .normal)
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
    public func configure(circle: Circle?, post: Post?) {
        self.circle = circle
        self.post = post
        guard let circlePhoto = self.circle?.circleProfilePhoto else {
            fatalError("Can't get Profile Photo")
        }
        let url = URL(string: circlePhoto)
        profileName.setTitle(self.circle?.name, for: .normal)
        profileImage.sd_setImage(with: url, completed: nil)
    }
    
    //MARK: - Actions
    @objc private func pressProfileName() {
        delegate?.pressProfileName(goto: self.circle)
    }
    @objc private func pressMoreButton() {
        delegate?.pressMoreButton(with: self.post)
    }
}
