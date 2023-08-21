//
//  MonthlySchedulPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MonthlySchedulPresenter: ViewToPresenterMonthlySchedulProtocol {

    // MARK: Properties
    var view: PresenterToViewMonthlySchedulProtocol?
    var interactor: PresenterToInteractorMonthlySchedulProtocol?
    var router: PresenterToRouterMonthlySchedulProtocol?
    
    func setRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func loadedData() {
        interactor?.loadDataInView()
    }
    
    func showToVC(index: Int, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, indxed: Int, arrSchedule: [MedicineSchedul], medicineLabel: UILabel, navigationController: UINavigationController) {
        router?.pushToVCWithData(index: index, medName: medName, medType: medType, firstDose: firstDose, hr: hr, min: min, sec: sec, isUpdate: isUpdate, indxed: indxed, arrSchedule: arrSchedule, medicineLabel: medicineLabel, navigationController: navigationController)
    }
    
    func setVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func cellForRowAt(tableView: UITableView, arrSchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell {
        interactor?.cellFor(tableView: tableView, arrSchedule: arrSchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func showTittleAndBtn(questionLbl: UILabel, nextBtn: UIButton, tableView: UITableView) {
        interactor?.setTittleAndBtn(questionLbl: questionLbl, nextBtn: nextBtn, tableView: tableView)
    }
}

extension MonthlySchedulPresenter: InteractorToPresenterMonthlySchedulProtocol {
    func loadDatasucessfully(arrSchedule: [MedicineSchedul]) {
        view?.loadData(arrSchedule: arrSchedule)
    }
    
    func setIndexSuccessfully(index: Int?) {
        view?.setIndex(index: index)
    }
}
