//
//  PostingPhotoCollectionViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/23.
//

import UIKit

class PostingPhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PostingPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    public func configure(with image: UIImage) {
        self.imageView.image = image
    }
}
