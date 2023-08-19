//
//  AddMedicationPresenter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit

class AddMedicationPresenter: ViewToPresenterAddMedicationProtocol {

    // MARK: Properties
    var view: PresenterToViewAddMedicationProtocol?
    var interactor: PresenterToInteractorAddMedicationProtocol?
    var router: PresenterToRouterAddMedicationProtocol?
    
    func showTittle(nextBtn: UIButton, questionLbl: UILabel, noteLbl: UILabel) {
        interactor?.setUptittle(nextBtn: nextBtn, questionLbl: questionLbl, noteLbl: noteLbl)
    }
    
    func fetchRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func loadData(tableView: UITableView) {
        interactor?.loadData(tableView: tableView)
    }
    
    func showTxtField(txtFieldView: UIView, txtFieldName: UITextField, nextBtn: UIButton) {
        interactor?.setUpTxtField(txtFieldView: txtFieldView, txtFieldName: txtFieldName, nextBtn: nextBtn)
    }
    
    func txtViewShowChange(nextBtn: UIButton, tableView: UITableView, noteLbl: UILabel, txtFieldName: UITextField) {
        interactor?.txtViewDidChange(nextBtn: nextBtn, tableView: tableView, noteLbl: noteLbl, txtFieldName: txtFieldName)
    }
    
    func nextBtnAction(txtFieldName: UITextField, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController) {
        router?.PushAndPassData(txtFieldName: txtFieldName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isUpdate: isUpdate, index: index, navigationController: navigationController)
    }
    
    func showVC(stroyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(stroyBoardName: stroyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func showFilteredData(filterMed: [MedicineName], medArray: [MedicineName], filtered: Bool) -> Int {
        interactor?.loadFilterData(filterMed: filterMed, medArray: medArray, filtered: filtered) ?? 0
    }
    
    func showFilteredDataInTableView(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath) -> UITableViewCell {
        interactor?.showFilteredDataInTableView(tableView: tableView, filterMed: filterMed, medArray: medArray, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func showDidSelect(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath, nextBtn: UIButton, txtFiledName: UITextField) {
        interactor?.didSelect(tableView: tableView, filterMed: filterMed, medArray: medArray, indexPath: indexPath, nextBtn: nextBtn, txtFiledName: txtFiledName)
    }
    
    func getData(isUpdate: Bool, tittleLbl: UILabel, txtField: UITextField, nextBtn: UIButton, objMedicine: MedDetalis?) {
        interactor?.getData(isUpdate: isUpdate, tittleLbl: tittleLbl, txtField: txtField, nextBtn: nextBtn, objMedicine: objMedicine)
    }
}

extension AddMedicationPresenter: InteractorToPresenterAddMedicationProtocol {
    
    func showDataSuccessfully(arrMedName: [MedicineName]) {
        view?.showData(arrMedName: arrMedName)
    }
}
