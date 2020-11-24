//
//  CircleViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

import Alamofire
import UIKit
import SwiftyJSON

// 동아리 이미지
// 소속 위치 카테고리
// 설명

/*
 -  Header
 - 동아리 이미지
 - 소속  / 위치  / 카테고리
 - 설명
 - Posts
 -Post Cell
 */

class CircleViewController: UIViewController {
    private var circleModel: Circle?
    private var circlePosts = [Post]()
    private var circleHeaderView = CircleHeaderView()
    private var circleID: Int = 0
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(FeedHeaderTableViewCell.self,
                           forCellReuseIdentifier: FeedHeaderTableViewCell.reuseIdentifier)
        tableView.register(FeedPostTableViewCell.self,
                           forCellReuseIdentifier: FeedPostTableViewCell.reuseIdentifier)
        tableView.register(FeedActionTableViewCell.self,
                           forCellReuseIdentifier: FeedActionTableViewCell.reuseIdentifier)
        tableView.register(FeedCommentTableViewCell.self,
                           forCellReuseIdentifier: FeedCommentTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: self.circleID)
        tableView.delegate = self
        tableView.dataSource = self
        circleHeaderView.delegate = self
        view.addSubview(circleHeaderView)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    public func configure(with circleID: Int) {
        //현재 로그인 한 유저가 관리자면 수정 버튼 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        self.circleID = circleID
        let urlToRequest = "http://3.35.240.252:8080/circles/found"
        let parameters: Parameters = [
            "circleId" : "\(circleID)"
        ]
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        AF.request(urlToRequest, method: .post, parameters: parameters, encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        let json = JSON(data)
                        self.circleModel = Circle(fromJson: json)
                        self.navigationItem.title = "\(self.circleModel?.name ?? "No Name")"
                        self.circleHeaderView.configure(with: self.circleModel)
                        self.circlePosts = self.circleModel?.circlePosts ?? [Post]()
                        self.circlePosts.reverse()
                        let userEmail = UserDefaults.standard.string(forKey: "email")
                        guard let email = userEmail else {
                            fatalError("Can't Find User email")
                        }
                        for member in self.circleModel?.circleMember ?? [CircleMember]() {
                            //이미 동아리 멤버라면
                            if member.email == email {
                                self.circleHeaderView.buttonHidden(followButton: true, registerButton: true, signOutButton: false, unfollowButton: true)
                            }
                        }
                        for member in self.circleModel?.circleFollower ?? [User]() {
                            //이미 팔로우 한 멤버라면
                            if member.email == email {
                                self.circleHeaderView.buttonHidden(followButton: true, registerButton: false, signOutButton: true, unfollowButton: false)
                            }
                        }
                        self.tableView.reloadData()
                    }
                   }
    }
    @objc private func didTapAddButton() {
        let vc = PostingViewController()
        vc.title = "Posting"
        vc.hidesBottomBarWhenPushed = true
        vc.configure(with: self.circleID)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CircleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let circlePostCount = circlePosts.count
        if circlePostCount == 0 {
            return 1
        }
        else {
            return (5 * (circlePostCount))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: - Bring The Model
        if indexPath.section % 5 == 0 {
            return UITableViewCell()
        }
        else if indexPath.section % 5 == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedHeaderTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FeedHeaderTableViewCell else {
                fatalError("FeedHeaderTableViewCell")
            }
            cell.configure(circle: circleModel, post: circlePosts[indexPath.section / 5])
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 5 == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FeedPostTableViewCell else {
                fatalError("FeedPostTableViewCell")
            }
            let post = circlePosts[indexPath.section / 5]
            cell.configure(model: post)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 5 == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedActionTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FeedActionTableViewCell else {
                fatalError("FeedActionTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 5 == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCommentTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FeedCommentTableViewCell else {
                fatalError("FeedCommentTableViewCell Error")
            }
            cell.configure(with: circlePosts[indexPath.section / 5])
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section % 5 == 1 {
            return 60
        } else if indexPath.section % 5 == 2 {
            return tableView.width
        } else if indexPath.section % 5 == 3 {
            return 60
        } else if indexPath.section % 5 == 4 {
            return 80
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section % 5 == 4 {
            return UIView()
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section % 5 == 4 {
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return circleHeaderView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return view.width
        }
        return 0
    }
}

extension CircleViewController: FeedCommentTableViewCellDelegate {
    func didTapMoreComment(comments: [Comment], post: Post?) {
        let vc = CommentViewController()
        vc.title = "Comments"
        vc.configure(comments: comments, post: post)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CircleViewController: CircleHeaderViewDelegate {
    func didTapFollowButton() {
        let requestURL = "http://3.35.240.252:8080/users/follower/\(circleID)"
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        AF.request(requestURL, method: .post, parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        self.circleHeaderView.buttonHidden(followButton: true, registerButton: false,
                                                           signOutButton: true, unfollowButton: false)
                    }
                   }
    }
    
    func didTapRegisterButton() {
        let requestURL = "http://3.35.240.252:8080/users/joinCircle/\(circleID)"
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        AF.request(requestURL, method: .post, parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        self.circleHeaderView.buttonHidden(followButton: true, registerButton: true,
                                                           signOutButton: false, unfollowButton: true)
                    }
                   }
    }
    func didTapsignOutCircleButton() {
        let requestURL = "http://3.35.240.252:8080/delete/myCircle"
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        let parameter: Parameters = [
            "deleteId": "\(circleID)"
        ]
        AF.request(requestURL, method: .delete, parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        print(data)
                        self.circleHeaderView.buttonHidden(followButton: false, registerButton: false,
                                                           signOutButton: true, unfollowButton: true)
                    }
                   }
    }
    func didTapUnFollowButton() {
//         "/delete/follower"
        let requestURL = "http://3.35.240.252:8080/delete/follower"
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        let parameter: Parameters = [
            "deleteId": "\(circleID)"
        ]
        AF.request(requestURL, method: .delete, parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        self.circleHeaderView.buttonHidden(followButton: false, registerButton: false,
                                                           signOutButton: true, unfollowButton: true)
                    }
                   }
    }
}
