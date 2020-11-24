//
//  MyPageVC.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit
import SwiftyJSON
import Alamofire

class MyPageVC: UIViewController {
    
    //Collection View?
    private var user: User?
    
    // View For User Information
    private let uiView = UserInfoView()
    
    
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
        getUserInfo()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .plain, target: self, action: #selector(didTapSettingButton))
        tableView.separatorStyle = .none
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
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
        tableView.reloadData()
    }
    
    private func getUserInfo() {
        guard let userNickname = UserDefaults.standard.string(forKey: "userNickname") else {
            fatalError("Can't get userNickname")
        }
        guard let accessToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get accessToken")
        }
        let urlToRequest = "http://3.35.240.252:8080/users/found"
        let parameters: Parameters = [
            "nickName" : "\(userNickname)"
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization" : "Bearer \(accessToken)"
        ]
        AF.request(urlToRequest, method: .post,
                   parameters: parameters, encoding: JSONEncoding.default,
                   headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        let userJSON = JSON(data)
                        self.user = User(fromJson: userJSON)
                        self.uiView.configure(with: self.user)
                        self.tableView.reloadData()
                    }
                   }
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
            return user?.myCircle?.count ?? 0
        } else if section == 1 {
            return user?.followCircle?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCircleTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? MyCircleTableViewCell else {
                fatalError("My Circle TableviewCell Error!")
            }
            cell.selectionStyle = .none
            cell.configure(with: user?.myCircle[indexPath.row])
            tableView.separatorStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FollowTableViewCell else {
                fatalError("Follow TableviewCell Error!")
            }
            cell.selectionStyle = .none
            cell.configure(with: user?.followCircle[indexPath.row])
            tableView.separatorStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let circleViewController = CircleViewController()
        if indexPath.section == 0 {
            circleViewController.configure(with: user?.myCircle[indexPath.row].id ?? 0)
        } else if indexPath.section == 1 {
            circleViewController.configure(with: user?.followCircle[indexPath.row].id ?? 0)
        }
        navigationController?.pushViewController(circleViewController, animated: true)
    }
}
