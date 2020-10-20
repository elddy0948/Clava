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
    
    private func mockData() {
        let circle = Circle(name: "DCA", organization: "Dong-A", description: "Welcome", circleProfilePhoto: "None", follower: [], circleMember: [], category: "Computer", post: [])
        let dumpData = User(email: "elddy@naver.com", password: "1234", userName: "Holuck", nickName: "Holuck", gender: .male, organization: "Dong-A", birth: Date(), myCircle: [circle], followCircle: [circle], join: Date(), profilePhoto: nil)
    }
}

extension MyCircleVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {

        } else if section == 1 {

        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        return 5
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
