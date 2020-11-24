//
//  CommentViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

import UIKit
import Alamofire
import SwiftyJSON

class CommentViewController: UIViewController {
    
    private var comments = [Comment]()
    private var post: Post?
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let addCommentButton: UIButton = {
        let button = UIButton()
        button.setTitle("게시", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    private let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        commentTableView.delegate = self
        commentTableView.dataSource = self
        view.addSubview(commentTableView)
        view.addSubview(commentTextField)
        view.addSubview(addCommentButton)
        addCommentButton.addTarget(self, action: #selector(didTapAddCommentButton), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewHeight = view.height - 30
        let commentTextfieldHeight = viewHeight / 20
        let commentButtonWidth = view.width / 5
        commentTableView.frame = CGRect(x: 0, y: 0, width: view.width, height: viewHeight - commentTextfieldHeight)

        commentTextField.frame = CGRect(x: 4, y: commentTableView.bottom, width: view.width - commentButtonWidth, height: commentTextfieldHeight)
        addCommentButton.frame = CGRect(x: commentTextField.right, y: commentTableView.bottom,
                                        width: commentButtonWidth, height: commentTextfieldHeight)

    }
    
    @objc private func didTapAddCommentButton() {
        let commentURL = "http://3.35.240.252:8080/posts/\(post?.id ?? 0)/comment"
        let parameters: Parameters = [
            "description": "\(commentTextField.text ?? "")"
        ]
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        AF.request(commentURL, method: .post, parameters: parameters, encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        let json = JSON(data)
                        self.comments.append(Comment(fromJson: json))
                        self.commentTableView.reloadData()
                    }
                   }
        commentTextField.text = ""
        commentTableView.reloadData()
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
    
    public func configure(comments: [Comment], post: Post?) {
        self.comments = comments
        self.post = post
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CommentTableViewCell else {
            fatalError("Can't Create CommentTableViewCell")
        }
        cell.configure(with: comments[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descriptionCount = comments[indexPath.row].descriptionField.count
        if descriptionCount > 100 {
            return CGFloat(descriptionCount * 2)
        }
        return 40
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let userNickname = UserDefaults.standard.string(forKey: "userNickname") else {
            fatalError("Can't get userNickname")
        }
        if userNickname == comments[indexPath.row].author {
            //can edit
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let requestURL = "http://3.35.240.252:8080/delete/comment"
            guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
                fatalError("Can't get user Token")
            }
            guard let commentId = comments[indexPath.row].id else {
                fatalError("Can't get comment id")
            }
            let parameters: Parameters = [
                "deleteId": commentId
            ]
            
            AF.request(requestURL, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: [
                "Authorization" : "Bearer \(userToken)"
            ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    print(data)
                }
            }
            self.comments.remove(at: indexPath.row)
            self.commentTableView.beginUpdates()
            self.commentTableView.deleteRows(at: [indexPath], with: .automatic)
            self.commentTableView.endUpdates()
        }
    }
}
