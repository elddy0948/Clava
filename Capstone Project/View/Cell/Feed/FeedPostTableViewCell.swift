//
//  FeedPostTableViewCell.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit
import SDWebImage
/*
 - Post Image
 */

class FeedPostTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FeedPostTableViewCell"
    private var imageCollectionView: UICollectionView?
    private var photo = [Photo]()

    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = false
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: contentView.width, height: contentView.height)

        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //Cell Register
        imageCollectionView?.register(PhotoCollectionViewCell.self,
                                      forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        
        imageCollectionView?.delegate = self
        imageCollectionView?.dataSource = self
        
        guard let collectionView = imageCollectionView else {
            return
        }
        collectionView.backgroundColor = .yellow
        contentView.addSubview(collectionView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCollectionView?.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photo = [Photo]()
    }

    public func configure(model: Post) {
        for image in model.postPhoto {
            photo.append(image)
        }
        imageCollectionView?.reloadData()
    }
}

extension FeedPostTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Can't create PhotoCollectionViewCell")
        }
        cell.backgroundColor = .red
        cell.configure(with: photo[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
}
