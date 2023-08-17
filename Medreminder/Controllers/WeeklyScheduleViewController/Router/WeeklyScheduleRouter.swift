//
//  WeeklyScheduleRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class WeeklyScheduleRouter: PresenterToRouterWeeklyScheduleProtocol {
    
    // MARK: Static methods
    static func createModule(vc: WeeklyScheduleViewController) {
        
        let presenter: ViewToPresenterWeeklyScheduleProtocol & InteractorToPresenterWeeklyScheduleProtocol = WeeklySchedulePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = WeeklyScheduleRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = WeeklyScheduleInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVCWithData(medicineTittle: UILabel, navigationController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "MedicinePurpose", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FirstDoseVC") as! FirstDoseVC
        let detalis = Medicine(medicineName: medicineTittle.text!)
        vc.medicinePurpose = detalis
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
}
