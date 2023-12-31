//
//  TabBarContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewTabBarProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTabBarProtocol {
    
    var view: PresenterToViewTabBarProtocol? { get set }
    var interactor: PresenterToInteractorTabBarProtocol? { get set }
    var router: PresenterToRouterTabBarProtocol? { get set }
    func showTabBar(tabBar: UITabBar)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTabBarProtocol {
    
    var presenter: InteractorToPresenterTabBarProtocol? { get set }
    func tabBarSet(tabBar: UITabBar)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTabBarProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTabBarProtocol {
    
}
