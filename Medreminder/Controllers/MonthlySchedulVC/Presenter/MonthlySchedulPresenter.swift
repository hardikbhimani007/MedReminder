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
    
    func showToVC(medicineLabel: UILabel, navigationController: UINavigationController) {
        router?.pushToVCWithData(medicineLabel: medicineLabel, navigationController: navigationController)
    }
    
    func setVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func cellForRowAt(tableView: UITableView, arrSchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell {
        interactor?.cellFor(tableView: tableView, arrSchedule: arrSchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension MonthlySchedulPresenter: InteractorToPresenterMonthlySchedulProtocol {
    func loadDatasucessfully(arrSchedule: [MedicineSchedul]) {
        view?.loadData(arrSchedule: arrSchedule)
    }
}