//
//  MedicineStrengthContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMedicineStrengthProtocol {
   func showData(arrStregth: [medicineType])
    func showGetStrength(getStrength: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMedicineStrengthProtocol {
    
    var view: PresenterToViewMedicineStrengthProtocol? { get set }
    var interactor: PresenterToInteractorMedicineStrengthProtocol? { get set }
    var router: PresenterToRouterMedicineStrengthProtocol? { get set }
    func showTxtFieldAndBtn(txtField: UITextField, nextBtn: UIButton)
    func showRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func tittleLblAndBtn(noteLbl: UILabel, tittleLbl: UILabel, nextBtn: UIButton, tableView: UITableView)
    func loadedData()
    func setTxtViewDidChange(nextBtn: UIButton, txtField: UITextField, tittleLbl: UILabel)
    func setNextBtn(medicineName: UILabel, txtField: UITextField, getStrenth: String, navigationController: UINavigationController)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func setcellForRow(tableView: UITableView, indexPath: IndexPath, arrStrength: [medicineType], selectedIndex: Int) -> UITableViewCell
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMedicineStrengthProtocol {
    
    var presenter: InteractorToPresenterMedicineStrengthProtocol? { get set }
    func setTxtFieldAndBtn(txtField: UITextField, nextBtn: UIButton)
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func setTittleLblAndBtn(noteLbl: UILabel, tittleLbl: UILabel, nextBtn: UIButton, tableView: UITableView)
    func loadData()
    func txtViewDidChange(nextBtn: UIButton, txtField: UITextField, tittleLbl: UILabel)
    func cellForRow(tableView: UITableView, indexPath: IndexPath, arrStrength: [medicineType], selectedIndex: Int) -> UITableViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMedicineStrengthProtocol {
    func loadDataSuceessfully(arrStregth: [medicineType])
    func showGetStrengthSucessfully(getStrength: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMedicineStrengthProtocol {
    func clickNextBtn(medicineName: UILabel, txtField: UITextField, getStrenth: String, navigationController: UINavigationController)
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
