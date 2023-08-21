//
//  MedicinePurposePresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicinePurposePresenter: ViewToPresenterMedicinePurposeProtocol {

    // MARK: Properties
    var view: PresenterToViewMedicinePurposeProtocol?
    var interactor: PresenterToInteractorMedicinePurposeProtocol?
    var router: PresenterToRouterMedicinePurposeProtocol?
    
    func titleFieldAndBtn(txtFieldView: UIView, txtField: UITextField, nextBtn: UIButton) {
        interactor?.setTitleFieldAndBtn(txtFieldView: txtFieldView, txtField: txtField, nextBtn: nextBtn)
    }
    
    func showLoadedAPI(tableView: UITableView) {
        interactor?.loadAPI(tableView: tableView)
    }
    
    func showRegisterNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView) {
        interactor?.registerNib(nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier, tableView: tableView)
    }
    
    func btnAndLabel(questionLbl: UILabel, noteLbl: UILabel, nextBtn: UIButton) {
        interactor?.setBtnAndLabel(questionLbl: questionLbl, noteLbl: noteLbl, nextBtn: nextBtn)
    }
    
    func showTxtViewDidChange(nextBtn: UIButton, tableView: UITableView, txtField: UITextField, noteLbl: UILabel) {
        interactor?.txtViewDidChange(nextBtn: nextBtn, tableView: tableView, txtField: txtField, noteLbl: noteLbl)
    }
    
    func showToVCWithData(txtField: UILabel, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController) {
        router?.pushToVCWithData(txtField: txtField, medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isUpdate: isUpdate, index: index, navigationController: navigationController)
    }
    
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func setNumberOfRowSection(filterMed: [MedicineName], arrMedPupose: [MedicineName], filtered: Bool) -> Int {
        interactor?.numberOfRowSection(filterMed: filterMed, arrMedPupose: arrMedPupose, filtered: filtered) ?? 0
    }
    
    func setCellForRow(tableView: UITableView, filterMed: [MedicineName], arrMedPupose: [MedicineName], indexPath: IndexPath) -> UITableViewCell {
        interactor?.cellForRow(tableView: tableView, filterMed: filterMed, arrMedPupose: arrMedPupose, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func didselectRowAT(filterMed: [MedicineName], arrMedPupose: [MedicineName], txtField: UITextField, nextBtn: UIButton, indexPath: IndexPath) {
        interactor?.didselect(filterMed: filterMed, arrMedPupose: arrMedPupose, txtField: txtField, nextBtn: nextBtn, indexPath: indexPath)
    }
}

extension MedicinePurposePresenter: InteractorToPresenterMedicinePurposeProtocol {
    func showDataSucessfully(arrMedPupose: [MedicineName]) {
        view?.showData(arrMedPupose: arrMedPupose)
    }
}
