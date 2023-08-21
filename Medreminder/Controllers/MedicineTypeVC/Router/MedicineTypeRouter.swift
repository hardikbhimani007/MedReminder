//
//  MedicineTypeRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicineTypeRouter: PresenterToRouterMedicineTypeProtocol {
    
    // MARK: Static methods
    static func createModule(vc: MedicineTypeVC) {
        
        let presenter: ViewToPresenterMedicineTypeProtocol & InteractorToPresenterMedicineTypeProtocol = MedicineTypePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = MedicineTypeRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = MedicineTypeInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVC(medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicineLbl: UILabel, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "AddMedication", bundle: nil).instantiateViewController(withIdentifier: "MedicineStrengthVC") as! MedicineStrengthVC
        let objMedicine = MedDetalis(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isUpdate, index: index)
        let detalis = Medicine(medicineName: medicineLbl.text!)
        vc.objMedicine = objMedicine
        vc.medicine = detalis
        do {
            let data = try JSONEncoder().encode(objMedicine)
            UserDefaults.standard.set(data, forKey: "ObjMedicine")
        } catch let error {
            print("Error encoding: \(error)")
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushTo(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
