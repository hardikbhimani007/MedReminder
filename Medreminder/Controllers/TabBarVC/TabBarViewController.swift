//
//  TabBarViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class TabBarViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterTabBarProtocol?
    
}

extension TabBarViewController: PresenterToViewTabBarProtocol{
    // TODO: Implement View Output Methods
}
