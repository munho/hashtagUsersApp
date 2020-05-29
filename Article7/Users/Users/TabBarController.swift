//
//  TabBarController.swift
//  Users
//
//  Created by Nitigya Kapoor on 03/04/20.
//  Copyright © 2020 Dhruvik Chevli. All rights reserved.
//

import UIKit

class MasterTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTabs()
    }
    
    fileprivate func setupTabs(){
        
        
        let navigationController = UINavigationController(rootViewController: TableViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        
        let userScreenController = navigationController
        userScreenController.tabBarItem = UITabBarItem(title : "Users", image : UIImage(systemName: "person")!, tag: 0)
        
        let sampleScreenController = SampleScreen()
        sampleScreenController.tabBarItem = UITabBarItem(title: "Sample", image: UIImage(systemName: "questionmark")!, tag: 1)

        viewControllers = [userScreenController,sampleScreenController]
        
    }
    
    fileprivate func setupLayout(){
        tabBar.isTranslucent = true
        tabBar.barTintColor = .black
    }
}


