//
//  MedicineStrengthRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import Alamofire

class MedicineStrengthRouter: PresenterToRouterMedicineStrengthProtocol {
    
    // MARK: Static methods
    static func createModule(vc: MedicineStrengthVC) {
        
        let presenter: ViewToPresenterMedicineStrengthProtocol & InteractorToPresenterMedicineStrengthProtocol = MedicineStrengthPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = MedicineStrengthRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = MedicineStrengthInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func clickNextBtn(medicineName: UILabel, txtField: UITextField, getStrenth: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "MedicinePurpose", bundle: nil).instantiateViewController(withIdentifier: "MedicinePurposeVC") as! MedicinePurposeVC
        let detalis = Medicine(medicineName: "\(medicineName.text ?? ""), \(txtField.text!) \(getStrenth)")
        vc.medicinePurpose = detalis
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
