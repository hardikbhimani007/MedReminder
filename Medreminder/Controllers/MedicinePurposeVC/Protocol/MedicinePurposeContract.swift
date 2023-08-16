//
//  MedicinePurposeContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMedicinePurposeProtocol {
    func showData(arrMedPupose: [MedicineName])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMedicinePurposeProtocol {
    
    var view: PresenterToViewMedicinePurposeProtocol? { get set }
    var interactor: PresenterToInteractorMedicinePurposeProtocol? { get set }
    var router: PresenterToRouterMedicinePurposeProtocol? { get set }
    func titleFieldAndBtn(txtFieldView: UIView, txtField: UITextField, nextBtn: UIButton)
    func showLoadedAPI(tableView: UITableView)
    func showRegisterNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView)
    func btnAndLabel(questionLbl: UILabel, noteLbl: UILabel, nextBtn: UIButton)
    func showTxtViewDidChange(nextBtn: UIButton, tableView: UITableView, txtField: UITextField, noteLbl: UILabel)
    func showToVCWithData(txtField: UILabel, navigationController: UINavigationController)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func setNumberOfRowSection(filterMed: [MedicineName], arrMedPupose: [MedicineName], filtered: Bool) -> Int
    func setCellForRow(tableView: UITableView, filterMed: [MedicineName], arrMedPupose: [MedicineName], indexPath: IndexPath) -> UITableViewCell
    func didselectRowAT(filterMed: [MedicineName], arrMedPupose: [MedicineName], txtField: UITextField, nextBtn: UIButton, indexPath: IndexPath)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMedicinePurposeProtocol {
    
    var presenter: InteractorToPresenterMedicinePurposeProtocol? { get set }
    func setTitleFieldAndBtn(txtFieldView: UIView, txtField: UITextField, nextBtn: UIButton)
    func loadAPI(tableView: UITableView)
    func registerNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView)
    func setBtnAndLabel(questionLbl: UILabel, noteLbl: UILabel, nextBtn: UIButton)
    func txtViewDidChange(nextBtn: UIButton, tableView: UITableView, txtField: UITextField, noteLbl: UILabel)
    func numberOfRowSection(filterMed: [MedicineName], arrMedPupose: [MedicineName], filtered: Bool) -> Int
    func cellForRow(tableView: UITableView, filterMed: [MedicineName], arrMedPupose: [MedicineName], indexPath: IndexPath) -> UITableViewCell
    func didselect(filterMed: [MedicineName], arrMedPupose: [MedicineName], txtField: UITextField, nextBtn: UIButton, indexPath: IndexPath)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMedicinePurposeProtocol {
    func showDataSucessfully(arrMedPupose: [MedicineName])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMedicinePurposeProtocol {
    func pushToVCWithData(txtField: UILabel, navigationController: UINavigationController)
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
