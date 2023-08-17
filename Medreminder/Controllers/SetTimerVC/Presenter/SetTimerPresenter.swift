//
//  SetTimerPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SetTimerPresenter: ViewToPresenterSetTimerProtocol {

    // MARK: Properties
    var view: PresenterToViewSetTimerProtocol?
    var interactor: PresenterToInteractorSetTimerProtocol?
    var router: PresenterToRouterSetTimerProtocol?
    
    func showBtn(nextBtn: UIButton, updateBtn: UIButton) {
        interactor?.setBtn(nextBtn: nextBtn, updateBtn: updateBtn)
    }
    
    func showLblsAndBtn(hrLbl: UILabel, minLbl: UILabel, secLbl: UILabel, setTimeLbl: UILabel, nextBtn: UIButton) {
        interactor?.setUpLblsAndBtn(hrLbl: hrLbl, minLbl: minLbl, secLbl: secLbl, setTimeLbl: setTimeLbl, nextBtn: nextBtn)
    }
    
    func showLocalNotification(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?) {
        interactor?.setLocalNotification(hour: hour, minute: minute, second: second, objMedicine: objMedicine)
    }
    
    func addDataFrom(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?) {
        interactor?.addDataFromDatabase(hour: hour, minute: minute, second: second, objMedicine: objMedicine)
    }
    
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func updateData(objMedicine: MedDetalis?, hour: Int, minute: Int, second: Int, navigationController: UINavigationController) {
        router?.updateDataWithVC(objMedicine: objMedicine, hour: hour, minute: minute, second: second, navigationController: navigationController)
    }
}

extension SetTimerPresenter: InteractorToPresenterSetTimerProtocol {
    func showTimeSuccessfully(objMedicine: MedDetalis?) {
        view?.showTime(objMedicine: objMedicine)
    }
}
