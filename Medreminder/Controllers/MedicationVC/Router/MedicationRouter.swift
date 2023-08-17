//
//  MedicationRouter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit

class MedicationRouter: PresenterToRouterMedicationProtocol {
    
    // MARK: Static methods
    static func createModule(vc: MedicationVC) {
        
        let presenter: ViewToPresenterMedicationProtocol & InteractorToPresenterMedicationProtocol = MedicationPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = MedicationRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = MedicationInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
 
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
    
}
