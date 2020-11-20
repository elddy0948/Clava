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
    private var followCircles = [Circle]()
    private var myCircles = [Circle]()
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
        
        let userEmail = UserDefaults.standard.string(forKey: "email")
        let userPassword = UserDefaults.standard.string(forKey: "password")
        
        if userEmail == nil || userPassword == nil {
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
        print(parameters)
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
                        self.followCircles = self.user?.followCircle ?? [Circle]()
                        self.myCircles = self.user?.myCircle ?? [Circle]()
                        self.feedTableView.reloadData()
                    }
                   }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedTableView)
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedTableView.frame = view.bounds
    }
}

//MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 * (followCircles.count)
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
            cell.configure(model: followCircles[indexPath.section / 4])
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 4 == 1 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedPostTableViewCell else {
                fatalError("FeedPostTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 4 == 2 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedActionTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedActionTableViewCell else {
                fatalError("FeedActionTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 4 == 3 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedCommentTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedCommentTableViewCell else {
                fatalError("FeedCommentTableViewCell Error")
            }
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
    func pressProfileName(goto circle: Circle?) {
        let vc = CircleViewController()
        vc.circleModel = circle
        navigationController?.pushViewController(vc, animated: true)
    }
}
