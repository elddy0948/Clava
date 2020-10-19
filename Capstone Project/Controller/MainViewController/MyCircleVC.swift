//
//  MyCircleVC.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

/*
  - 내가 가입한 동아리
  - 팔로우 한 동아리
 */

class MyCircleVC: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCircleTableViewCell.self,
                           forCellReuseIdentifier: MyCircleTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension MyCircleVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCircleTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? MyCircleTableViewCell else {
            fatalError("My Circle TableView Cell Error!")
        }
        return cell
    }
}
extension MyCircleVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
