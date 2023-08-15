//
//  HomePresenter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import FSCalendar

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
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
    
    func setAlertHasLunchedBefore(names: String, tableView: UITableView, vc: HomeVC) {
        interactor?.setAlertHasLunchedBefore(names: names, tableView: tableView, vc: vc)
    }
    
    func registerNibShow(tableView: UITableView, nibName: String, nibName2: String, forHeaderFooterViewReuseIdentifier: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, nibName2: nibName2, forHeaderFooterViewReuseIdentifier: forHeaderFooterViewReuseIdentifier, forCellReuseIdentifier: forCellReuseIdentifier)
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
    
    func showTakeMedicineVC(arrMedDetalis: [MedicineDetalis], indexPath: IndexPath, navigationController: UINavigationController) {
        router?.pushToTakeMedicineVC(arrMedDetalis: arrMedDetalis, indexPath: indexPath, navigationController: navigationController)
    }
    
    func showHeaderView(tableView: UITableView) -> UIView {
        interactor?.setHeaderView(tableView: tableView) ?? UIView()
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func showDataSuccessfully(arrMedDetalis: [MedicineDetalis]) {
        view?.showData(arrMedDetalis: arrMedDetalis)
    }
    
    func fetchingPopUp(names: String, tableView: UITableView, vc: HomeVC) {
        router?.showAlert(names: names, tableView: tableView, vc: vc)
    }
    
}
