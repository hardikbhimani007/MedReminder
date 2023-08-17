//
//  MedicineTypePresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicineTypePresenter: ViewToPresenterMedicineTypeProtocol {

    // MARK: Properties
    var view: PresenterToViewMedicineTypeProtocol?
    var interactor: PresenterToInteractorMedicineTypeProtocol?
    var router: PresenterToRouterMedicineTypeProtocol?
    
    func showRegisterNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView) {
        interactor?.registerNib(nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier, tableView: tableView)
    }
    
    func showLoadedData() {
        interactor?.loadData()
    }
    
    func showtittleAndLbl(noteLbl: UILabel, nextBtn: UIButton, tableView: UITableView) {
        interactor?.setUptittleAndLbl(noteLbl: noteLbl, nextBtn: nextBtn, tableView: tableView)
    }
    
    func storeValueWithPush(medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicineLbl: UILabel, navigationController: UINavigationController) {
        router?.pushToVC(medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isUpdate: isUpdate, index: index, medicineLbl: medicineLbl, navigationController: navigationController)
    }
    
    func showVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushTo(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func showCellForRow(tableView: UITableView, arrMedicine: [medicineType], selectedIndex: Int, indexPath: IndexPath, nextBtn: UIButton) -> UITableViewCell {
        interactor?.cellForRow(tableView: tableView, arrMedicine: arrMedicine, selectedIndex: selectedIndex, indexPath: indexPath, nextBtn: nextBtn) ?? UITableViewCell()
    }
}

extension MedicineTypePresenter: InteractorToPresenterMedicineTypeProtocol {
    func showDataSuccessfully(arrMedicineType: [medicineType]) {
        view?.showData(arrMedicineType: arrMedicineType)
    }
    
    func showSelectedIndexType(selectedIndexType: String) {
        view?.showSelectedIndexType(selectedIndexType: selectedIndexType)
    }
}
