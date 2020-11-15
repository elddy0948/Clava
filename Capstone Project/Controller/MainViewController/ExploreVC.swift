//
//  ExploreVC.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExploreVC: UIViewController {
    var circles = [Circle]()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllCircles()
        print("viewWillAppear : \(circles)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.titleView = searchBar
        view.addSubview(tableView)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    
    private func getAllCircles() {

        var circles = [Circle]()
        let url = "http://3.35.240.252:8080/circles"
        DispatchQueue.global().sync {
            AF.request(url, method: .get).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        let json = JSON(data)
                        DispatchQueue.global(qos: .default).sync {
                            for item in json.arrayValue {
                                let circle = Circle(fromJson: item)
                                circles.append(circle)
                                print(circles)
                            }
                        }
                    }
            }
            print("getAllCircles : \(circles)")
        }
    }
}


//MARK: - TableViewDelegate
extension ExploreVC: UITableViewDelegate {
    
}

//MARK: - TableViewDataSource
extension ExploreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


//MARK: - SearchBarDelegate
extension ExploreVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        guard let text = searchBar.text,
              !text.isEmpty else {
            return
        }
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,
                                                            target: self, action: #selector(didCancelSearch))
    }
    
    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    private func query(_ text: String) {
        //perform the search in the back end
    }
}
