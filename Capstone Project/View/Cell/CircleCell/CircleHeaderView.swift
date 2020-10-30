//
//  CircleHeaderView.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/30.
//

import UIKit

class CircleHeaderView: UIView {
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let circleBelong: UILabel = {
        let label = UILabel()
        label.text = "Dong-A Univ"
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let circleArea: UILabel = {
        let label = UILabel()
        label.text = "Pusan"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let circleCategory: UILabel = {
        let label = UILabel()
        label.text = "Security"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    private let circleDescription: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.text = "Here is Description"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        self.addSubview(circleImageView)
        self.addSubview(circleArea)
        self.addSubview(circleBelong)
        self.addSubview(circleCategory)
        self.addSubview(circleDescription)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = self.width / 3
        circleImageView.frame = CGRect(x: size, y: 10, width: size, height: size)
        circleImageView.layer.cornerRadius = size / 2
        
        let labelSize = self.width / 3
        let heightFromImage = circleImageView.bottom + 8
        circleBelong.frame = CGRect(x: 0, y: heightFromImage, width: labelSize, height: 30)
        circleArea.frame = CGRect(x: circleBelong.right, y: heightFromImage, width: labelSize, height: 30)
        circleCategory.frame = CGRect(x: circleArea.right, y: heightFromImage, width: labelSize, height: 30)
        
        circleDescription.frame = CGRect(x: 0, y: circleCategory.bottom + 8, width: self.width, height: self.height - circleImageView.height - 56)
        
    }
}
