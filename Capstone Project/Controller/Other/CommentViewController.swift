//
//  CommentViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

import UIKit

class CommentViewController: UIViewController {
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private let addCommentButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        commentTableView.delegate = self
        commentTableView.dataSource = self
        view.addSubview(commentTableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        commentTableView.frame = view.bounds
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CommentTableViewCell else {
            fatalError("Can't Create CommentTableViewCell")
        }
        cell.backgroundColor = .blue
        return cell
    }
}
