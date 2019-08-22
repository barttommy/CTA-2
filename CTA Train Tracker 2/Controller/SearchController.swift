//
//  SearchController.swift
//  CTA Train Tracker 2
//
//  Created by Thomas Bart on 8/22/19.
//  Copyright © 2019 Thomas Bart. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    
    let cellId = "station"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Fullerton"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
