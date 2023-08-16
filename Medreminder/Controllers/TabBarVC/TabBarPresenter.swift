//
//  TabBarPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation

class TabBarPresenter: ViewToPresenterTabBarProtocol {

    // MARK: Properties
    var view: PresenterToViewTabBarProtocol?
    var interactor: PresenterToInteractorTabBarProtocol?
    var router: PresenterToRouterTabBarProtocol?
}

extension TabBarPresenter: InteractorToPresenterTabBarProtocol {
    
}
