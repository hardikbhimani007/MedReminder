//
//  WeeklyScheduleContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewWeeklyScheduleProtocol {
    func showData(arrDaySchedule: [MedicineSchedul])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWeeklyScheduleProtocol {
    
    var view: PresenterToViewWeeklyScheduleProtocol? { get set }
    var interactor: PresenterToInteractorWeeklyScheduleProtocol? { get set }
    var router: PresenterToRouterWeeklyScheduleProtocol? { get set }
    func showRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func showLoadedData()
    func lblAndBtn(questionLbl: UILabel, nextBtn: UIButton, tableview: UITableView)
    func showToVCWithData(medicineTittle: UILabel, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func cellForRowAt(tableView: UITableView, arrDaySchedule: [MedicineSchedul], selectedIndex: [Int], nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWeeklyScheduleProtocol {
    
    var presenter: InteractorToPresenterWeeklyScheduleProtocol? { get set }
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func loadData()
    func setLblAndBtn(questionLbl: UILabel, nextBtn: UIButton, tableview: UITableView)
    func cellFor(tableView: UITableView, arrDaySchedule: [MedicineSchedul], selectedIndex: [Int], nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWeeklyScheduleProtocol {
    func showDataSuccessfully(arrDaySchedule: [MedicineSchedul])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWeeklyScheduleProtocol {
    func pushToVCWithData(medicineTittle: UILabel, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController)
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
