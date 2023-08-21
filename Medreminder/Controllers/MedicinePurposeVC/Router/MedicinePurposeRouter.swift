//
//  MedicinePurposeRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicinePurposeRouter: PresenterToRouterMedicinePurposeProtocol {
    
    // MARK: Static methods
    static func createModule(vc: MedicinePurposeVC) {
        
        let presenter: ViewToPresenterMedicinePurposeProtocol & InteractorToPresenterMedicinePurposeProtocol = MedicinePurposePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = MedicinePurposeRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = MedicinePurposeInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVCWithData(txtField: UILabel, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "MedicinePurpose", bundle: nil).instantiateViewController(withIdentifier: "MonthlySchedulVC") as! MonthlySchedulVC
        let detalis = Medicine(medicineName: txtField.text!)
        let objMed = MedDetalis(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isUpdate, index: index)
        vc.objMedicine = objMed
        vc.medicinePurpose = detalis
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
