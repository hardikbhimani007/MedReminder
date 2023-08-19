//
//  AddMedicationContract.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewAddMedicationProtocol {
    func showData(arrMedName: [MedicineName])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAddMedicationProtocol {
    
    var view: PresenterToViewAddMedicationProtocol? { get set }
    var interactor: PresenterToInteractorAddMedicationProtocol? { get set }
    var router: PresenterToRouterAddMedicationProtocol? { get set }
    func showTittle(nextBtn: UIButton, questionLbl: UILabel, noteLbl: UILabel)
    func fetchRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func loadData(tableView: UITableView)
    func showTxtField(txtFieldView: UIView, txtFieldName: UITextField, nextBtn: UIButton)
    func txtViewShowChange(nextBtn: UIButton, tableView: UITableView, noteLbl: UILabel, txtFieldName: UITextField)
    func nextBtnAction(txtFieldName: UITextField, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController)
    func showVC(stroyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func showFilteredData(filterMed: [MedicineName], medArray: [MedicineName], filtered: Bool) -> Int
    func showFilteredDataInTableView(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath) -> UITableViewCell
    func showDidSelect(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath, nextBtn: UIButton, txtFiledName: UITextField)
    func getData(isUpdate: Bool, tittleLbl: UILabel, txtField: UITextField, nextBtn: UIButton, objMedicine: MedDetalis?)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAddMedicationProtocol {
    
    var presenter: InteractorToPresenterAddMedicationProtocol? { get set }
    func setUptittle(nextBtn: UIButton, questionLbl: UILabel, noteLbl: UILabel)
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func loadData(tableView: UITableView)
    func setUpTxtField(txtFieldView: UIView, txtFieldName: UITextField, nextBtn: UIButton)
    func txtViewDidChange(nextBtn: UIButton, tableView: UITableView, noteLbl: UILabel, txtFieldName: UITextField)
    func loadFilterData(filterMed: [MedicineName], medArray: [MedicineName], filtered: Bool) -> Int
    func showFilteredDataInTableView(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath, nextBtn: UIButton, txtFiledName: UITextField)
    func getData(isUpdate: Bool, tittleLbl: UILabel, txtField: UITextField, nextBtn: UIButton, objMedicine: MedDetalis?)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAddMedicationProtocol {
    func showDataSuccessfully(arrMedName: [MedicineName])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAddMedicationProtocol {
    func PushAndPassData(txtFieldName: UITextField, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, navigationController: UINavigationController)
    func pushToVC(stroyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
