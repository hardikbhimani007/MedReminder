//
//  TabBarVC.swift
//  Medreminder
//
//  Created by MacOS on 27/07/2023.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .cyan
        
    }
}
