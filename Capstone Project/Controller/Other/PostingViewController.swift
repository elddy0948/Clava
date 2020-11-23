//
//  PostingViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/23.
//

import UIKit
import TLPhotoPicker
import Photos

class PostingViewController: UIViewController {
    // uiimagepicker
    
    private var collectionView: UICollectionView?
    private var selectedAssets = [TLPHAsset]()

    
    private let libraryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "folder"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width, height: view.width)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let selectedCollectionView = collectionView else {
            fatalError("Can't Make CollectionView")
        }
        selectedCollectionView.backgroundColor = .red
        view.addSubview(selectedCollectionView)
        view.addSubview(libraryButton)
        
        libraryButton.addTarget(self, action: #selector(selectImageFromLibrary), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 8, width: view.width, height: view.width)
        
        let buttonWidth: CGFloat = 60
        let buttonXPosition = (view.width / 2) - (buttonWidth / 2)
        libraryButton.frame = CGRect(x: buttonXPosition, y: (collectionView?.bottom ?? view.width) + 4 , width: buttonWidth, height: 60)
    }
    
    @objc private func selectImageFromLibrary() {
        let vc = TLPhotosPickerViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension PostingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.selectedAssets.count)
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension PostingViewController: TLPhotosPickerViewControllerDelegate {
    func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        self.selectedAssets = withTLPHAssets
        return true
    }
    func photoPickerDidCancel() {
        // cancel
        self.collectionView?.reloadData()
    }
    func dismissComplete() {
        // picker viewcontroller dismiss completion
        self.collectionView?.reloadData()
    }
}
