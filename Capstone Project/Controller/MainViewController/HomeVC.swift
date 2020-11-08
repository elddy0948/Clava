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
    
    private let user = User(email: "holuck@naver.com", password: "123456", userName: "Hojoon", nickName: "Holuck",
                            gender: .male, organization: "Dong-A Univ", birth: Date(), myCircle: [Circle(name: "DCA", organization: "Dong-A Univ", description: "Computer Circle", circleProfilePhoto: "", follower: [], circleMember: [], category: "Computer", post: [])], followCircle: [], join: Date(), profilePhoto: nil)
    
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
        
        if UserDefaults.standard.string(forKey: "email") == nil || UserDefaults.standard.string(forKey: "password") == nil {
            let vc = LoginViewController()
            vc.title = "LOG IN"
            navigationController?.pushViewController(vc, animated: true)
        }
        let parameter: Parameters = [
            "email": "aaa.com",
            "password": "test"
        ]
        let url: String = "http://3.35.240.252:8080/auth"
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default,
                   headers: [
                    "Content-Type": "application/json"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    print(response.data!)
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(section)
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //MARK: - Bring The Model
        guard let myCircle = user.myCircle else {fatalError("Can't Get MyCircle")}
        let model = myCircle[indexPath.section / 4]
        
        if indexPath.section == 0 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedHeaderTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedHeaderTableViewCell else {
                fatalError("FeedHeaderTableViewCell")
            }
            
            // FeedHeaderTableViewCell Delegate 채택
            cell.delegate = self
            cell.configure(model: model)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedPostTableViewCell else {
                fatalError("FeedPostTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedActionTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedActionTableViewCell else {
                fatalError("FeedActionTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 3 {
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
        if indexPath.section == 0 {
            return 60
        } else if indexPath.section == 1 {
            return tableView.width
        } else if indexPath.section == 2 {
            return 60
        } else if indexPath.section == 3 {
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
    func pressProfileName() {
//        let vc = CircleViewController()
        let vc = LoginViewController()
        vc.title = "DCA"
        navigationController?.pushViewController(vc, animated: true)
    }
}
