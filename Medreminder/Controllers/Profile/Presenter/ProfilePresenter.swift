//
//  ProfilePresenter.swift
//  Medreminder
//
//  Created by MacOS on 17/08/2023.
//  
//

import Foundation
import UIKit

class ProfilePresenter: ViewToPresenterProfileProtocol {

    // MARK: Properties
    var view: PresenterToViewProfileProtocol?
    var interactor: PresenterToInteractorProfileProtocol?
    var router: PresenterToRouterProfileProtocol?
    
    func showChangeLanguage(pageNotFound: UILabel, notesLbl: UILabel) {
        interactor?.changeLanguage(pageNotFound: pageNotFound, notesLbl: notesLbl)
    }
}

extension ProfilePresenter: InteractorToPresenterProfileProtocol {
    
}
