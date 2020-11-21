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
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCircles = [Circle]()
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllCircles()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Circles..."
        definesPresentationContext = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func filterContentForSearchText(searchText: String) {
        filteredCircles = circles.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    private func getAllCircles() {
        let urlToRequest = "http://3.35.240.252:8080/circles/all"
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else {
            fatalError("Can't get user Token")
        }
        AF.request(urlToRequest, method: .post, parameters: nil, encoding: JSONEncoding.default,
                   headers: [
                    "Authorization" : "Bearer \(userToken)"
                   ], interceptor: nil, requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        let json = JSON(data).arrayValue
                        for item in json {
                            self.circles.append(Circle(fromJson: item))
                        }
                        self.tableView.reloadData()
                    }
                   }
    }
}


//MARK: - TableViewDelegate
extension ExploreVC: UITableViewDelegate {
    
}

//MARK: - TableViewDataSource
extension ExploreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCircles.count
        } else {
            return circles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.reuseIdentifier, for: indexPath) as? ExploreTableViewCell else {
            fatalError("Error at ExploreTableViewCell")
        }
        if isFiltering {
            cell.configure(with: filteredCircles[indexPath.row])
        } else {
            cell.configure(with: circles[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let circleViewController = CircleViewController()
        if isFiltering {
            circleViewController.configure(with: filteredCircles[indexPath.row].id)
        } else {
            circleViewController.configure(with: circles[indexPath.row].id)
        }
        navigationController?.pushViewController(circleViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - UISearchResultsUpdating
extension ExploreVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}
