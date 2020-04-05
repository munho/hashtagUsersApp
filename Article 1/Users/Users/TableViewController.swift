//
//  TableViewController.swift
//  Users
//
//  Created by Dhruvik Chevli on 28/03/20.
//  Copyright © 2020 Dhruvik Chevli. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    

    fileprivate func setUpTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.layer.cornerRadius = 15
        let t:Int = indexPath.row
        if(t%2==0)
        {
            cell.backgroundColor = .systemPink
        }
        else
        {
            cell.backgroundColor = .systemTeal
        }
        return cell
    }

}


