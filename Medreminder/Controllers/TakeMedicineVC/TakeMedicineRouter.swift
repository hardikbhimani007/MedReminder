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
    
    func pushToVC(medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isEdit: Bool, index: Int, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "AddMedication", bundle: nil).instantiateViewController(withIdentifier: "AddMedicationVC") as! AddMedicationVC
        let data = MedDetalis(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isEdit, index: index)
        vc.objMedicine = data
        vc.isUpdate = true
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
