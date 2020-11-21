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
    private var post: Post?

    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.masksToBounds = true

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
        contentView.addSubview(collectionView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCollectionView?.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.width)
    }

    public func configure(model: Post) {
        self.post = model
        imageCollectionView?.reloadData()
    }
}

extension FeedPostTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Can't create PhotoCollectionViewCell")
        }
        guard let photoURL = post?.postPhoto[indexPath.row].photoUrl else {
            fatalError("There is no Photo to Post")
        }
        cell.backgroundColor = .red
        cell.configure(with: photoURL)
        return cell
    }
}
