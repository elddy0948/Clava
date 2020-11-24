//
//  PostingViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/23.
//

import UIKit
import TLPhotoPicker
import Photos
import Alamofire
import SwiftyJSON

class PostingViewController: UIViewController {
    // uiimagepicker
    
    private var collectionView: UICollectionView?
    private var selectedAssets = [TLPHAsset]()
    private var uiimageArr = [UIImage]()
    private var urlArray = [String]()
    private var circleID: Int?
    
    private let libraryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "folder"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    private let postingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        return button
    }()
    
    private let descriptionField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        return textView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder.badge.plus")
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width, height: view.width)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PostingPhotoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: PostingPhotoCollectionViewCell.reuseIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let selectedCollectionView = collectionView else {
            fatalError("Can't Make CollectionView")
        }
        selectedCollectionView.backgroundColor = .systemBackground
        selectedCollectionView.backgroundView = backgroundView
        view.addSubview(selectedCollectionView)
        view.addSubview(libraryButton)
        view.addSubview(descriptionField)
        view.addSubview(postingButton)
        
        libraryButton.addTarget(self, action: #selector(selectImageFromLibrary), for: .touchUpInside)
        postingButton.addTarget(self, action: #selector(selectPostingButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 8, width: view.width, height: view.width)
        
        let textFieldHeight = view.width / 2
        descriptionField.frame = CGRect(x: 0, y: (collectionView?.bottom ?? view.width) + 12, width: view.width, height: textFieldHeight)
        
        let buttonWidth: CGFloat = 60
        let buttonXPosition = (view.width / 3) - (buttonWidth / 2)
        libraryButton.frame = CGRect(x: buttonXPosition, y: descriptionField.bottom + 12 , width: buttonWidth, height: 60)
        postingButton.frame = CGRect(x: libraryButton.right + buttonWidth, y: descriptionField.bottom + 4, width: buttonWidth, height: 60)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func selectImageFromLibrary() {
        let vc = TLPhotosPickerViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func selectPostingButton() {
        let requestURL = "http://3.35.240.252:8080/upload"
        guard let accessToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get accessToken")
        }
        for image in uiimageArr {
            guard let data = image.pngData() else {
                fatalError("Can't Create pngData")
            }
//            guard let data = image.jpegData(compressionQuality: 0.5) else {
//                fatalError("")
//            }
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "data",fileName: "file2.png", mimeType: "image/png")
            },
            to: requestURL, method: .post, headers: [
                "Authorization" : "Bearer \(accessToken)"
            ]).responseString { (response) in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.urlArray.append(data)
                    if self.urlArray.count == self.uiimageArr.count {
                        print(self.urlArray)
                        let postingURL = "http://3.35.240.252:8080/circles/\(self.circleID ?? 0)/posts"
                        let parameter: Parameters = [
                            "description": "\(self.descriptionField.text ?? "")",
                            "photoUrl": self.urlArray
                        ]
                        AF.request(postingURL,
                                   method: .post, parameters: parameter,
                                   encoding: JSONEncoding.default, headers: [
                                    "Authorization" : "Bearer \(accessToken)"
                                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                                    switch response.result {
                                    case .failure(let error):
                                        print(error)
                                    case .success(let data):
                                        print(data)
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                   }
                    }
                }
            }
        }
    }
    public func configure(with circle: Int) {
        self.circleID = circle
    }
}

extension PostingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingPhotoCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? PostingPhotoCollectionViewCell else {
            fatalError("Can't take PostingPhotoCollectionViewCell")
        }
        cell.configure(with: self.uiimageArr[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
}

extension PostingViewController: TLPhotosPickerViewControllerDelegate {
    func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        self.selectedAssets = withTLPHAssets
        for asset in self.selectedAssets {
            uiimageArr.append(asset.fullResolutionImage ?? UIImage())
        }
        self.collectionView?.reloadData()
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
