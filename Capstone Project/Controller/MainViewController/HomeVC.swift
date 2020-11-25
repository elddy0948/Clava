//
//  HomeVC.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeVC: UIViewController {
    private var user: User?
    private var circlesForFeed = [Circle]()
    private var postsForFeed = [Post]()
    //MARK: - Views
    private let feedTableView: UITableView = {
        let tableView = UITableView()
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
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circlesForFeed = [Circle]()
        postsForFeed = [Post]()
        self.getFollowAndMyCircles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUser()
        feedTableView.separatorStyle = .none
        view.addSubview(feedTableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"),
                                                            style: .plain, target: self, action: #selector(didTapReloadButton))
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedTableView.frame = view.bounds
    }
    
    @objc private func didTapReloadButton() {
        self.authUser()
    }
    
    private func authUser() {
        let userEmail = UserDefaults.standard.string(forKey: "email")
        let userPassword = UserDefaults.standard.string(forKey: "password")
        
        if userEmail == "" || userPassword == "" || userEmail == nil || userPassword == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            guard let email = userEmail else { fatalError("Email Error") }
            guard let password = userPassword else { fatalError("Password Error") }
            let parameter: Parameters = [
                "email": "\(email)",
                "password": "\(password)"
            ]
            let url: String = "http://3.35.240.252:8080/auth"
            AF.request(url, method: .post, parameters: parameter,
                       encoding: JSONEncoding.default,
                       headers: [
                        "Content-Type": "application/json"
                       ],
                       interceptor: nil,
                       requestModifier: nil).responseJSON { (response) in
                        switch response.result {
                        case .failure(let error):
                            print(error)
                        case .success(let data):
                            let json = JSON(data)
                            let authInfo = Auth(fromJson: json)
                            UserDefaults.standard.set(authInfo.accessToken, forKey: "userToken")
                            UserDefaults.standard.set(authInfo.userNickname, forKey: "userNickname")
                            self.getFollowAndMyCircles()
                            self.feedTableView.reloadData()
                        }
                       }
        }
    }
    
    private func getFollowAndMyCircles() {
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
                        UserDefaults.standard.set(self.user?.id, forKey: "userID")
                        self.circlesForFeed = (self.user?.followCircle ?? [Circle]()) + (self.user?.myCircle ?? [Circle]())
                        for circle in self.circlesForFeed {
                            for post in circle.circlePosts {
                                self.postsForFeed.append(post)
                            }
                        }
                        self.postsForFeed.reverse()
                        self.feedTableView.reloadData()
                    }
                   }
    }
}

//MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 * (postsForFeed.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: - Bring The Model
        if indexPath.section % 4 == 0 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedHeaderTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedHeaderTableViewCell else {
                fatalError("FeedHeaderTableViewCell")
            }
            cell.delegate = self
            if postsForFeed.count >= (indexPath.section / 4) {
                let post: Post? = postsForFeed[indexPath.section / 4]
                for circle in circlesForFeed {
                    if circle.id == postsForFeed[indexPath.section / 4].circleId {
                        cell.configure(circle: circle, post: post)
                    }
                }
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 4 == 1 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedPostTableViewCell else {
                fatalError("FeedPostTableViewCell")
            }
            if postsForFeed.count >= indexPath.section / 4 {
                cell.configure(model: postsForFeed[indexPath.section / 4])
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 4 == 2 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedActionTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedActionTableViewCell else {
                fatalError("FeedActionTableViewCell")
            }
            if postsForFeed.count >= indexPath.section / 4 {
                cell.configure(with: postsForFeed[indexPath.section / 4])
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 4 == 3 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedCommentTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedCommentTableViewCell else {
                fatalError("FeedCommentTableViewCell Error")
            }
            if postsForFeed.count >= indexPath.section / 4 {
                cell.configure(with: postsForFeed[indexPath.section / 4])
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section % 4 == 0 {
            return 60
        } else if indexPath.section % 4 == 1 {
            return tableView.width
        } else if indexPath.section % 4 == 2 {
            return 60
        } else if indexPath.section % 4 == 3 {
            return 80
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section % 4 == 3 {
            return UIView()
        }
        
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section % 4 == 3 {
            return 50
        }
        return 0
    }
}


extension HomeVC: FeedHeaderTableViewCellDelegate {
    func pressMoreButton(with post: Post?) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "삭제하기", style: .default, handler: { (alert) in
            self.deleteFeed(post: post?.id)
            self.feedTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func pressProfileName(goto circle: Circle?) {
        let vc = CircleViewController()
        vc.configure(with: (circle?.id)!)
        navigationController?.pushViewController(vc, animated: true)
    }
    private func deleteFeed(post: Int?) {
        let deleteURL = "http://3.35.240.252:8080/delete/post"
        guard let accessToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get accessToken")
        }
        let parameters: Parameters = [
            "deleteId": "\(post ?? 0)"
        ]
        AF.request(deleteURL, method: .delete,
                   parameters: parameters,
                   encoding: JSONEncoding.default, headers: [
                    "Authorization" : "Bearer \(accessToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        self.viewWillAppear(true)
                    }
                   }
    }
}

extension HomeVC: FeedCommentTableViewCellDelegate {
    func didTapMoreComment(comments: [Comment], post: Post?) {
        let vc = CommentViewController()
        vc.title = "Comments"
        vc.configure(comments: comments, post: post)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: FeedActionTableViewCellDelegate {
    func didTapLikeButton(with post: Post?, button: UIButton?, tableviewCell: FeedActionTableViewCell) {
        if tableviewCell.didLikePost {
            //delete
            let deleteURL = "http://3.35.240.252:8080/delete/like"
            guard let accessToken = UserDefaults.standard.string(forKey: "userToken") else {
                fatalError("Can't get accessToken")
            }
            let parameters: Parameters = [
                "deleteId": post?.id ?? 0
            ]
            AF.request(deleteURL, method: .delete,
                       parameters: parameters,
                       encoding: JSONEncoding.default, headers: [
                        "Authorization" : "Bearer \(accessToken)"
                       ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                        switch response.result {
                        case .failure(let error):
                            print(error)
                        case .success(let data):
                            print(data)
                            button?.setImage(UIImage(systemName: "flame"), for: .normal)
                            tableviewCell.didLikePost = false
                        }
                       }
        }
        else {
            //add
            let likeURL = "http://3.35.240.252:8080/posts/\(post?.id ?? 0)/like"
            guard let accessToken = UserDefaults.standard.string(forKey: "userToken") else {
                fatalError("Can't get accessToken")
            }
            AF.request(likeURL, method: .post,
                       parameters: nil,
                       encoding: JSONEncoding.default, headers: [
                        "Authorization" : "Bearer \(accessToken)"
                       ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                        switch response.result {
                        case .failure(let error):
                            print(error)
                        case .success(let data):
                            print(data)
                            button?.setImage(UIImage(systemName: "flame.fill"), for: .normal)
                            tableviewCell.didLikePost = true
                        }
                       }
        }
    }
}
