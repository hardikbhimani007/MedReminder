//
//  MonthlySchedulContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMonthlySchedulProtocol {
    func loadData(arrSchedule: [MedicineSchedul])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMonthlySchedulProtocol {
    
    var view: PresenterToViewMonthlySchedulProtocol? { get set }
    var interactor: PresenterToInteractorMonthlySchedulProtocol? { get set }
    var router: PresenterToRouterMonthlySchedulProtocol? { get set }
    func setRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func loadedData()
    func showToVC(medicineLabel: UILabel, navigationController: UINavigationController)
    func setVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func cellForRowAt(tableView: UITableView, arrSchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMonthlySchedulProtocol {
    
    var presenter: InteractorToPresenterMonthlySchedulProtocol? { get set }
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func loadDataInView()
    func cellFor(tableView: UITableView, arrSchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMonthlySchedulProtocol {
    func loadDatasucessfully(arrSchedule: [MedicineSchedul])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMonthlySchedulProtocol {
    func pushToVCWithData(medicineLabel: UILabel, navigationController: UINavigationController)
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
