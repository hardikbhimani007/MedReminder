//
//  TabBarVC.swift
//  Medreminder
//
//  Created by MacOS on 27/07/2023.
//

import UIKit

class TabBarVC: UITabBarController {

    // MARK: - Properties
    var presenter: ViewToPresenterTabBarProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TabBarRouter.createModule(vc: self)
        navigationController?.navigationBar.isHidden = true
        presenter?.showTabBar(tabBar: tabBar)
    }
}
extension TabBarVC: PresenterToViewTabBarProtocol{
    // TODO: Implement View Output Methods
}
