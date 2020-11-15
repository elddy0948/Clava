//
//  MyPageVC.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit

class MyPageVC: UIViewController {
    
    //Collection View?
    
    
    private var user = User(email: "elddy@naver.com", password: "1234", userName: "Holuck", nickName: "Holuck", gender: .male, organization: "Dong-A", birth: Date(), myCircle: [Circle(name: "DCA", organization: "Dong-A", description: "Welcome", circleProfilePhoto: "None", follower: [], circleMember: [], category: "Computer", post: [])], followCircle: [Circle(name: "DCA", organization: "Dong-A", description: "Welcome", circleProfilePhoto: "None", follower: [], circleMember: [], category: "Computer", post: [])], join: Date(), profilePhoto: nil)
    
    // View For User Information
    private let uiView: UIView = {
        let view = UserInfoView()
        return view
    }()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCircleTableViewCell.self,
                           forCellReuseIdentifier: MyCircleTableViewCell.reuseIdentifier)
        tableView.register(FollowTableViewCell.self,
                           forCellReuseIdentifier: FollowTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapSettingButton))

        view.addSubview(tableView)
        view.addSubview(uiView)
    }
    
    @objc private func didTapSettingButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        uiView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width / 1.5)
        tableView.frame = CGRect(x: 0, y: uiView.bottom, width: view.width, height: view.height / 1.5)
    }

}

extension MyPageVC: UITableViewDelegate {
    
}

extension MyPageVC: UITableViewDataSource {
    
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
