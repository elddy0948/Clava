//
//  CircleViewController.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/28.
//

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
    
    private let user = User(email: "holuck@naver.com", password: "123456", userName: "Hojoon", nickName: "Holuck",
                            gender: .male, organization: "Dong-A Univ", birth: Date(), myCircle: [Circle(fromJson: JSON())], followCircle: [], join: Date(), profilePhoto: nil)
    
    private let tableView: UITableView = {
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

extension CircleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //MARK: - Bring The Model
        guard let myCircle = user.myCircle else {fatalError("Can't Get MyCircle")}
        let model = myCircle[indexPath.section / 4]
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedHeaderTableViewCell.reuseIdentifier,
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedPostTableViewCell else {
                fatalError("FeedPostTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedActionTableViewCell.reuseIdentifier,
                                                               for: indexPath) as? FeedActionTableViewCell else {
                fatalError("FeedActionTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCommentTableViewCell.reuseIdentifier,
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return CircleHeaderView()
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return view.width
        }
        return 0
    }
}

extension CircleViewController: FeedHeaderTableViewCellDelegate {
    func pressProfileName() {
    }    
}



