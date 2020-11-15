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
    private var circles = [Circle]()
    private var json = [JSON]()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCircles()
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
        print("Dispatch Queue")
        let urlToRequest = "http://3.35.240.252:8080/circles"
        AF.request(urlToRequest, method: .get).responseJSON(queue: .main) { (response) in
            self.json = JSON(response.data ?? "").arrayValue
            for item in self.json {
                self.circles.append(Circle(fromJson: item))
            }
            self.tableView.reloadData()
        }
    }
}


//MARK: - TableViewDelegate
extension ExploreVC: UITableViewDelegate {
    
}

//MARK: - TableViewDataSource
extension ExploreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.reuseIdentifier, for: indexPath) as? ExploreTableViewCell else {
            fatalError("Error at ExploreTableViewCell")
        }
        cell.configure(with: circles[indexPath.row])
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
