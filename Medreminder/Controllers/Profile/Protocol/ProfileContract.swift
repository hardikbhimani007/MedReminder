//
//  ProfileContract.swift
//  Medreminder
//
//  Created by MacOS on 17/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewProfileProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProfileProtocol {
    
    var view: PresenterToViewProfileProtocol? { get set }
    var interactor: PresenterToInteractorProfileProtocol? { get set }
    var router: PresenterToRouterProfileProtocol? { get set }
    func showChangeLanguage(pageNotFound: UILabel, notesLbl: UILabel)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProfileProtocol {
    
    var presenter: InteractorToPresenterProfileProtocol? { get set }
    func changeLanguage(pageNotFound: UILabel, notesLbl: UILabel)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProfileProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterProfileProtocol {
    
}
