//
//  TableViewController.swift
//  Users
//
//  Created by Dhruvik Chevli on 28/03/20.
//  Copyright © 2020 Dhruvik Chevli. All rights reserved.
//

import UIKit
import Disk

class TableViewController: UITableViewController,PassingUser {
    
    var users = [User](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    func passUser(user: User) {
        self.users.append(user)
        self.tableView.reloadData()
    }
    
    @objc func goToSecondScreen(){
        let sampleScreen = SampleScreen()
        sampleScreen.delegate = self
        self.navigationController?.present(sampleScreen, animated: true)
        view.snapshotView(afterScreenUpdates: true)
    }

    fileprivate func setUpTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.title = "Users"
        let camera = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSecondScreen))
        self.navigationItem.rightBarButtonItem = camera
        tableView.register(UserCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.rowHeight = 150
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //new code starts
        do{
            users = try Disk.retrieve("users.json", from: .caches, as: [User].self)
        }
        catch{
            fetchData()
        }
        tableView.reloadData()
        //new code ends
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
            switch result{
            case .failure(let error):
                print(error)
            case .success(let usersRes):
                self?.users = usersRes
            }
        }
    }
}



