//
//  PhotoCollectionViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/21.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    public func configure(with image: String) {
        let url = URL(string: image)
        print(url)
        imageView.sd_setImage(with: url, completed: nil)
    }
}
