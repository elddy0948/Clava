//
//  CommentViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

import UIKit

class CommentViewController: UIViewController {
    
    private var comments = [Comment]()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
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
        print(commentTextField.text ?? "")
    }
    
    public func configure(comments: [Comment]) {
        self.comments = comments
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descriptionCount = comments[indexPath.row].descriptionField.count
        return CGFloat(descriptionCount)
    }
}
