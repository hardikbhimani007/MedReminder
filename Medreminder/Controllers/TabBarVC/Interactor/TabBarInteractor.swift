//
//  TabBarInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class TabBarInteractor: PresenterToInteractorTabBarProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterTabBarProtocol?
    
    func tabBarSet(tabBar: UITabBar) {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .cyan
    }
}
