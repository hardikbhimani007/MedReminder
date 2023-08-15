//
//  MedicationContract.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import FSCalendar

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMedicationProtocol {
    func showData(arrMedDetalis: [MedicineDetalis])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMedicationProtocol {
    
    var view: PresenterToViewMedicationProtocol? { get set }
    var interactor: PresenterToInteractorMedicationProtocol? { get set }
    var router: PresenterToRouterMedicationProtocol? { get set }
    func setUp(datePicker: FSCalendar, button: UIButton)
    func showContextMenu(tittle1: String, tittle2: String, tittle3: String, addBtn: UIButton, navigationController: UINavigationController)
    func showDataFromView(tableView: UITableView)
    func showChangesTittle(name: String, btn: UIButton)
    func registerNibShow(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func tapGesture(datePickerView: FSCalendar)
    func loadDataForCell(tableView: UITableView, arrMedDtalis: [MedicineDetalis], indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMedicationProtocol {
    
    var presenter: InteractorToPresenterMedicationProtocol? { get set }
    func setUp(datePicker: FSCalendar, button: UIButton)
    func setUpContextMenu(tittle1: String, tittle2: String, tittle3: String, addBtn: UIButton, navigationController: UINavigationController)
    func getDataFromDataBase(tableView: UITableView)
    func settittleOfBtnAndLanguage(name: String, btn: UIButton)
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func tapGesture(datePickerView: FSCalendar)
    func loadDataForCell(tableView: UITableView, arrMedDtalis: [MedicineDetalis], indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMedicationProtocol {
    func showDataSuccessfully(arrMedDetalis: [MedicineDetalis])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMedicationProtocol {
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
