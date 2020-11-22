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
    private let circleHeaderView = CircleHeaderView()
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
        view.addSubview(circleHeaderView)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
                        self.circleHeaderView.configure(with: self.circleModel)
                        self.tableView.reloadData()
                    }
                   }
    }
    @objc private func didTapAddButton() {
        print("didTapAddButton")
    }
}

extension CircleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let circlePostCount = circleModel?.circlePosts.count ?? 0
        if circlePostCount == 0 {
            return 1
        }
        else {
            return (5 * (circleModel?.circlePosts.count ?? 0))
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
            cell.configure(circle: circleModel, post: circleModel?.circlePosts[indexPath.section / 5])
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section % 5 == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FeedPostTableViewCell else {
                fatalError("FeedPostTableViewCell")
            }
            let post = circleModel?.circlePosts[indexPath.section / 5]
            cell.configure(model: post!)
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
            cell.configure(with: circleModel?.circlePosts[indexPath.section / 5])
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
