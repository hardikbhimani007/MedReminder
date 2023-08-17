//
//  TakeMedicineRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class TakeMedicineRouter: PresenterToRouterTakeMedicineProtocol {
    
    // MARK: Static methods
    static func createModule(vc: TakeMedicineVC) {
        
        
        let presenter: ViewToPresenterTakeMedicineProtocol & InteractorToPresenterTakeMedicineProtocol = TakeMedicinePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = TakeMedicineRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = TakeMedicineInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVC(index: Int?, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "AddMedication", bundle: nil).instantiateViewController(withIdentifier: "AddMedicationVC") as! AddMedicationVC
        vc.isUpdate = true
        vc.index = index
        navigationController.pushViewController(vc, animated: true)
    }
    
    func setRootView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: nextViewController) // set RootViewController
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = false
        APP_DELEGATE.window?.makeKeyAndVisible()
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
    }
}
