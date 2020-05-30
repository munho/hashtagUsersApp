//
//  TableViewController.swift
//  Users
//
//  Created by Dhruvik Chevli on 28/03/20.
//  Copyright © 2020 Dhruvik Chevli. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var users = [User](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }

    fileprivate func setUpTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: "Cell")
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSecondScreen))
        self.navigationItem.rightBarButtonItem = add
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = "Users"
    }
    
    @objc func goToSecondScreen(){
        let sampleScreen = SampleScreen()
        self.navigationController?.present(sampleScreen, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setUpTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UserCell
        cell.layer.cornerRadius = 15
        let user = users[indexPath.row]
        cell.set(res : user)
        return cell
    }

}

extension TableViewController {
    
    func fetchData(){
        Networking.sharedInstance.getUsers{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let usersRes):
                self?.users=usersRes
            }
        }
    }
    
}





