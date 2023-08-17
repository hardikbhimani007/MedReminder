//
//  TabBarPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class TabBarPresenter: ViewToPresenterTabBarProtocol {

    // MARK: Properties
    var view: PresenterToViewTabBarProtocol?
    var interactor: PresenterToInteractorTabBarProtocol?
    var router: PresenterToRouterTabBarProtocol?
    
    func showTabBar(tabBar: UITabBar) {
        interactor?.tabBarSet(tabBar: tabBar)
    }
}

extension TabBarPresenter: InteractorToPresenterTabBarProtocol {
    
}
