//
//  AddMedicationRouter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit

class AddMedicationRouter: PresenterToRouterAddMedicationProtocol {
    
    // MARK: Static methods
    static func createModule(vc: AddMedicationVC) {
        
        let presenter: ViewToPresenterAddMedicationProtocol & InteractorToPresenterAddMedicationProtocol = AddMedicationPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = AddMedicationRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = AddMedicationInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func PushAndPassData(txtFieldName: UITextField, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "AddMedication", bundle: nil).instantiateViewController(withIdentifier: "MedicineTypeVC") as! MedicineTypeVC
        let objMedDetalis = MedDetalis(medName: txtFieldName.text, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isUpdate, index: index)
        let detalis = Medicine(medicineName: txtFieldName.text!)
        vc.medicine = detalis
        vc.objMedicine = objMedDetalis
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToVC(stroyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: stroyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
