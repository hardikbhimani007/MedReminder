//
//  FirstDoseRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class FirstDoseRouter: PresenterToRouterFirstDoseProtocol {
    
    // MARK: Static methods
    static func createModule(vc: FirstDoseVC) {
        
        let presenter: ViewToPresenterFirstDoseProtocol & InteractorToPresenterFirstDoseProtocol = FirstDosePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = FirstDoseRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = FirstDoseInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVCWithData(selectedIndex: String, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicinetittle: UILabel, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "MedicinePurpose", bundle: nil).instantiateViewController(withIdentifier: "SetTimerVC") as! SetTimerVC
        let detalis = Medicine(medicineName: medicinetittle.text!)
//        let objMedicine = MedDetalis(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isUpdate, index: index)
//        vc.objMedicine = objMedicine
        vc.medicinePurpose = detalis
        do {
            if let data = UserDefaults.standard.data(forKey: "ObjMedicine") {
                var objMed = try JSONDecoder().decode(MedDetalis.self, from: data)
                objMed = MedDetalis(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isUpdate, index: index)
                print(">>>>>>>>",objMed)
                vc.objMedicine = objMed
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
        vc.shouldShowUpdateButton = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
