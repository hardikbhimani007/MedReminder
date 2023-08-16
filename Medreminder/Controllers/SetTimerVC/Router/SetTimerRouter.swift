//
//  SetTimerRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import RealmSwift

class SetTimerRouter: PresenterToRouterSetTimerProtocol {
    
    // MARK: Static methods
    static func createModule(vc: SetTimerVC) {
        
        let presenter: ViewToPresenterSetTimerProtocol & InteractorToPresenterSetTimerProtocol = SetTimerPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = SetTimerRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = SetTimerInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
    
    func updateDataWithVC(objMedicine: MedDetalis?, hour: Int, minute: Int, second: Int, navigationController: UINavigationController) {
        let realm = try! Realm()
        try! realm.write({
            let update = realm.objects(MedicineDetalis.self)[objMedicine?.index ?? 0]
            update.medicineName = objMedicine?.medName
            update.medicineType = objMedicine?.medType
            update.firstDose = objMedicine?.firstDose
            update.hr = hour
            update.min = minute
            update.sec = second
        })
        navigationController.popToRootViewController(animated: true)
    }
}
