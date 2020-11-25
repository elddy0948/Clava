//
//  FeedActionTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

protocol FeedActionTableViewCellDelegate: AnyObject {
    func didTapLikeButton(with post: Post?, button: UIButton?, tableviewCell: FeedActionTableViewCell)
}

class FeedActionTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FeedActionTableViewCell"
    weak var delegate: FeedActionTableViewCellDelegate?
    private var post: Post?
    public var didLikePost = false
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "flame"), for: .normal)
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.addSubview(likeButton)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.setImage(nil, for: .normal)
    }
    
    //MARK: - Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        likeButton.frame = CGRect(x: 2, y: 2, width: size, height: size)
    }
    
    public func configure(with post: Post?) {
        self.post = post
        didLikePost = false
        guard let likes = post?.postLike else {
            fatalError("There is no likes!!")
        }
        let userID = UserDefaults.standard.integer(forKey: "userID")
        for like in likes {
            if like.userId == userID {
                //좋아요를 누른 상태
                didLikePost = true
                break
            }
        }
        if !didLikePost {
            likeButton.setImage(UIImage(systemName: "flame"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "flame.fill"), for: .normal)
        }
    }

    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton(with: self.post, button: self.likeButton, tableviewCell: self)
    }
}
