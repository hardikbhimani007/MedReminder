//
//  MonthlySchedulRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MonthlySchedulRouter: PresenterToRouterMonthlySchedulProtocol {
    
    // MARK: Static methods
    static func createModule(vc: MonthlySchedulVC) {
        
        let presenter: ViewToPresenterMonthlySchedulProtocol & InteractorToPresenterMonthlySchedulProtocol = MonthlySchedulPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = MonthlySchedulRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = MonthlySchedulInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVCWithData(index: Int, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, indxed: Int, arrSchedule: [MedicineSchedul], medicineLabel: UILabel, navigationController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "MedicinePurpose", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyScheduleViewController") as! WeeklyScheduleViewController
        let detalis = Medicine(medicineName: medicineLabel.text!)
        let objMedicine = MedDetalis(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isEdit: isUpdate, index: indxed)
        vc.objMedicine = objMedicine
        vc.index = index
        vc.arrSchedule = arrSchedule
        print(index)
        vc.medicinePurpose = detalis
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
