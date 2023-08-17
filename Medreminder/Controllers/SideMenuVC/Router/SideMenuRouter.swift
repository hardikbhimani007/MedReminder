//
//  SideMenuRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SideMenuRouter: PresenterToRouterSideMenuProtocol {
    
    // MARK: Static methods
    static func createModule(vc: SideMenuViewController) {
        
        let presenter: ViewToPresenterSideMenuProtocol & InteractorToPresenterSideMenuProtocol = SideMenuPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = SideMenuRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = SideMenuInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVC(navigationController: UINavigationController) {
        let transition:CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.popViewController(animated: true)
    }
}
