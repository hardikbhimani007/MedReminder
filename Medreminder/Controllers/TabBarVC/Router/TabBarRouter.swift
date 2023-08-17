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
    static func createModule(vc: TabBarVC) {
        
        let presenter: ViewToPresenterTabBarProtocol & InteractorToPresenterTabBarProtocol = TabBarPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = TabBarRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = TabBarInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
}
