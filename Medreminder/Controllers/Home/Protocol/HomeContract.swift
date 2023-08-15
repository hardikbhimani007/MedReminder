//
//  HomeContract.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import FSCalendar

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol {
    func showData(arrMedDetalis: [MedicineDetalis])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    func setUp(datePicker: FSCalendar, button: UIButton)
    func showContextMenu(tittle1: String, tittle2: String, tittle3: String, addBtn: UIButton, navigationController: UINavigationController)
    func showDataFromView(tableView: UITableView)
    func showChangesTittle(name: String, btn: UIButton)
    func setAlertHasLunchedBefore(names: String ,tableView: UITableView, vc: HomeVC)
    func registerNibShow(tableView: UITableView, nibName: String, nibName2: String, forHeaderFooterViewReuseIdentifier: String, forCellReuseIdentifier: String)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func tapGesture(datePickerView: FSCalendar)
    func loadDataForCell(tableView: UITableView, arrMedDtalis: [MedicineDetalis], indexPath: IndexPath) -> UITableViewCell
    func showTakeMedicineVC(arrMedDetalis: [MedicineDetalis], indexPath: IndexPath, navigationController: UINavigationController)
    func showHeaderView(tableView: UITableView) -> UIView
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    func setUp(datePicker: FSCalendar, button: UIButton)
    func setUpContextMenu(tittle1: String, tittle2: String, tittle3: String, addBtn: UIButton, navigationController: UINavigationController)
    func getDataFromDataBase(tableView: UITableView)
    func settittleOfBtnAndLanguage(name: String, btn: UIButton)
    func setAlertHasLunchedBefore(names: String ,tableView: UITableView, vc: HomeVC)
    func registerNib(tableView: UITableView, nibName: String, nibName2: String, forHeaderFooterViewReuseIdentifier: String, forCellReuseIdentifier: String)
    func tapGesture(datePickerView: FSCalendar)
    func loadDataForCell(tableView: UITableView, arrMedDtalis: [MedicineDetalis], indexPath: IndexPath) -> UITableViewCell
    func setHeaderView(tableView: UITableView) -> UIView
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol {
    func showDataSuccessfully(arrMedDetalis: [MedicineDetalis])
    func fetchingPopUp(names: String ,tableView: UITableView, vc: HomeVC)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol {
    func showAlert(names: String ,tableView: UITableView, vc: HomeVC)
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func pushToTakeMedicineVC(arrMedDetalis: [MedicineDetalis], indexPath: IndexPath, navigationController: UINavigationController)
}
