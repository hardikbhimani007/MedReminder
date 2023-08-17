//
//  TakeMedicinePresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class TakeMedicinePresenter: ViewToPresenterTakeMedicineProtocol {

    // MARK: Properties
    var view: PresenterToViewTakeMedicineProtocol?
    var interactor: PresenterToInteractorTakeMedicineProtocol?
    var router: PresenterToRouterTakeMedicineProtocol?
    
    func showToVC(index: Int?, navigationController: UINavigationController) {
        router?.pushToVC(index: index, navigationController: navigationController)
    }
    
    func localNotification(med1: String, medName: String, medType: String, firstDose: String, medNameLbl: UILabel, medTypeLbl: UILabel, schedulLbl: UILabel, timeLbl: UILabel, hr: Int, min: Int) {
        interactor?.setUpLocalNotification(med1: med1, medName: medName, medType: medType, firstDose: firstDose, medNameLbl: medNameLbl, medTypeLbl: medTypeLbl, schedulLbl: schedulLbl, timeLbl: timeLbl, hr: hr, min: min)
    }
    
    func deleteDataFromDatabase(index: Int?) {
        interactor?.deleteData(index: index)
    }
    
    func showRootView() {
        router?.setRootView()
    }
}

extension TakeMedicinePresenter: InteractorToPresenterTakeMedicineProtocol {
    
}
