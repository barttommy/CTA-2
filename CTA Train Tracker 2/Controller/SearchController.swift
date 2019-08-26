//
//  SearchController.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/22/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {
    
    let cellId = "station"
    lazy var searchBar: UISearchBar = UISearchBar()
    var filteredStations = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search Train Stations..."
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationItem.title = "Stations"
        self.tableView.tableHeaderView = searchBar
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = AppColor.viewBackground
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func searchBar (_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searching = false
            view.endEditing(true)
            self.tableView.reloadData()
        } else {
            searching = true
            filteredStations = stations.filter({$0.lowercased().contains(searchText.lowercased())})
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredStations.count
        } else {
            return stations.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let station : String
        if searching {
            station = filteredStations[indexPath.row]
        } else {
            station = stations[indexPath.row]
        }
        cell.textLabel?.text = station
        cell.textLabel?.textColor = AppColor.cellText
        cell.backgroundColor = AppColor.cellBackground
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arrivalsController = navigationController?.viewControllers[0] as! ArrivalsController
        let requestedStation: String
        if searching {
            requestedStation = filteredStations[indexPath.row]
        } else {
            requestedStation = stations[indexPath.row]
        }
        arrivalsController.requestedStation = requestedStation
        self.navigationController?.popViewController(animated: true)
    }
}
