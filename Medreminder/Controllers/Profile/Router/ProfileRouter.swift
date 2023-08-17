//
//  ProfileRouter.swift
//  Medreminder
//
//  Created by MacOS on 17/08/2023.
//  
//

import Foundation
import UIKit

class ProfileRouter: PresenterToRouterProfileProtocol {
    
    // MARK: Static methods
    static func createModule(vc: ProfileViewController) {
        
        let presenter: ViewToPresenterProfileProtocol & InteractorToPresenterProfileProtocol = ProfilePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = ProfileRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = ProfileInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
}
