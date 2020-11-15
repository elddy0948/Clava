//
//  MyCircleVC.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit
import SwiftyJSON

/*
  - 내가 가입한 동아리
  - 팔로우 한 동아리
 */

class MyCircleVC: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCircleTableViewCell.self,
                           forCellReuseIdentifier: MyCircleTableViewCell.reuseIdentifier)
        tableView.register(FollowTableViewCell.self,
                           forCellReuseIdentifier: FollowTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private var user = User(email: "elddy@naver.com", password: "1234", userName: "Holuck", nickName: "Holuck", gender: .male, organization: "Dong-A", birth: Date(), myCircle: [Circle(fromJson: JSON())], followCircle: [Circle(fromJson: JSON())], join: Date(), profilePhoto: nil)
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 70))
        let label = UILabel(frame: CGRect(x: 2, y: 2, width: header.width, height: header.height))
        header.addSubview(label)
        header.backgroundColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        if section == 0 {
            label.text = "My Circle"
        } else if section == 1 {
            label.text = "Follow Circle"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //section 0 ==> My Circle
        //section 1 ==> Follow Circle
        if section == 0 {
            return user.myCircle?.count ?? 0
        } else if section == 1 {
            return user.followCircle?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCircleTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? MyCircleTableViewCell else {
                fatalError("My Circle TableviewCell Error!")
            }
            tableView.separatorStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FollowTableViewCell else {
                fatalError("Follow TableviewCell Error!")
            }
            tableView.separatorStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}
extension MyCircleVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
