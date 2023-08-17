//
//  MedicineStrengthPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicineStrengthPresenter: ViewToPresenterMedicineStrengthProtocol {

    // MARK: Properties
    var view: PresenterToViewMedicineStrengthProtocol?
    var interactor: PresenterToInteractorMedicineStrengthProtocol?
    var router: PresenterToRouterMedicineStrengthProtocol?
    
    func showTxtFieldAndBtn(txtField: UITextField, nextBtn: UIButton) {
        interactor?.setTxtFieldAndBtn(txtField: txtField, nextBtn: nextBtn)
    }
    
    func showRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func tittleLblAndBtn(noteLbl: UILabel, tittleLbl: UILabel, nextBtn: UIButton, tableView: UITableView) {
        interactor?.setTittleLblAndBtn(noteLbl: noteLbl, tittleLbl: tittleLbl, nextBtn: nextBtn, tableView: tableView)
    }
    
    func loadedData() {
        interactor?.loadData()
    }
    
    func setTxtViewDidChange(nextBtn: UIButton, txtField: UITextField, tittleLbl: UILabel) {
        interactor?.txtViewDidChange(nextBtn: nextBtn, txtField: txtField, tittleLbl: tittleLbl)
    }
    
    func setNextBtn(medicineName: UILabel, txtField: UITextField, getStrenth: String, navigationController: UINavigationController) {
        router?.clickNextBtn(medicineName: medicineName, txtField: txtField, getStrenth: getStrenth, navigationController: navigationController)
    }
    
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func setcellForRow(tableView: UITableView, indexPath: IndexPath, arrStrength: [medicineType], selectedIndex: Int) -> UITableViewCell {
        interactor?.cellForRow(tableView: tableView, indexPath: indexPath, arrStrength: arrStrength, selectedIndex: selectedIndex) ?? UITableViewCell()
    }
}

extension MedicineStrengthPresenter: InteractorToPresenterMedicineStrengthProtocol {
    func loadDataSuceessfully(arrStregth: [medicineType]) {
        view?.showData(arrStregth: arrStregth)
    }
    
    func showGetStrengthSucessfully(getStrength: String) {
        view?.showGetStrength(getStrength: getStrength)
    }
}
