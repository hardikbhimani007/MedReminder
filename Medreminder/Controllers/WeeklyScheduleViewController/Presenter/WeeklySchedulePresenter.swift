//
//  WeeklySchedulePresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import Alamofire

class WeeklySchedulePresenter: ViewToPresenterWeeklyScheduleProtocol {

    // MARK: Properties
    var view: PresenterToViewWeeklyScheduleProtocol?
    var interactor: PresenterToInteractorWeeklyScheduleProtocol?
    var router: PresenterToRouterWeeklyScheduleProtocol?
    
    func showRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func showLoadedData() {
        interactor?.loadData()
    }
    
    func lblAndBtn(questionLbl: UILabel, nextBtn: UIButton, tableview: UITableView) {
        interactor?.setLblAndBtn(questionLbl: questionLbl, nextBtn: nextBtn, tableview: tableview)
    }
    
    func showToVCWithData(medicineTittle: UILabel, navigationController: UINavigationController) {
        router?.pushToVCWithData(medicineTittle: medicineTittle, navigationController: navigationController)
    }
    
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func cellForRowAt(tableView: UITableView, arrDaySchedule: [MedicineSchedul], selectedIndex: [Int], nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell {
        interactor?.cellFor(tableView: tableView, arrDaySchedule: arrDaySchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension WeeklySchedulePresenter: InteractorToPresenterWeeklyScheduleProtocol {
    func showDataSuccessfully(arrDaySchedule: [MedicineSchedul]) {
        view?.showData(arrDaySchedule: arrDaySchedule)
    }
}
