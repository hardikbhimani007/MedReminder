//
//  TabBarRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class TabBarRouter: PresenterToRouterTabBarProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = TabBarVC()
        
        let presenter: ViewToPresenterTabBarProtocol & InteractorToPresenterTabBarProtocol = TabBarPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = TabBarRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TabBarInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
