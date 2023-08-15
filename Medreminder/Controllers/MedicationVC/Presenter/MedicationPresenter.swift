//
//  MedicationPresenter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import FSCalendar

class MedicationPresenter: ViewToPresenterMedicationProtocol {

    // MARK: Properties
    var view: PresenterToViewMedicationProtocol?
    var interactor: PresenterToInteractorMedicationProtocol?
    var router: PresenterToRouterMedicationProtocol?
    
    func setUp(datePicker: FSCalendar, button: UIButton) {
        interactor?.setUp(datePicker: datePicker, button: button)
    }
    
    func showContextMenu(tittle1: String, tittle2: String, tittle3: String, addBtn: UIButton, navigationController: UINavigationController) {
        interactor?.setUpContextMenu(tittle1: tittle1, tittle2: tittle2, tittle3: tittle3, addBtn: addBtn, navigationController: navigationController)
    }
    
    func showDataFromView(tableView: UITableView) {
        interactor?.getDataFromDataBase(tableView: tableView)
    }
    
    func showChangesTittle(name: String, btn: UIButton) {
        interactor?.settittleOfBtnAndLanguage(name: name, btn: btn)
    }
    
    func registerNibShow(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func tapGesture(datePickerView: FSCalendar) {
        interactor?.tapGesture(datePickerView: datePickerView)
    }
    
    func loadDataForCell(tableView: UITableView, arrMedDtalis: [MedicineDetalis], indexPath: IndexPath) -> UITableViewCell {
        interactor?.loadDataForCell(tableView: tableView, arrMedDtalis: arrMedDtalis, indexPath: indexPath) ?? UITableViewCell()
    }

}

extension MedicationPresenter: InteractorToPresenterMedicationProtocol {
    func showDataSuccessfully(arrMedDetalis: [MedicineDetalis]) {
        view?.showData(arrMedDetalis: arrMedDetalis)
    }
}
