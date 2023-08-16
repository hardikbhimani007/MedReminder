//
//  MedicineTypeContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMedicineTypeProtocol {
    func showData(arrMedicineType: [medicineType])
    func showSelectedIndexType(selectedIndexType: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMedicineTypeProtocol {
    
    var view: PresenterToViewMedicineTypeProtocol? { get set }
    var interactor: PresenterToInteractorMedicineTypeProtocol? { get set }
    var router: PresenterToRouterMedicineTypeProtocol? { get set }
    func showRegisterNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView)
    func showLoadedData()
    func showtittleAndLbl(noteLbl: UILabel, nextBtn: UIButton, tableView: UITableView)
    func storeValueWithPush(medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicineLbl: UILabel, navigationController: UINavigationController)
    func showVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func showCellForRow(tableView: UITableView, arrMedicine: [medicineType], selectedIndex: Int, indexPath: IndexPath, nextBtn: UIButton) -> UITableViewCell
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMedicineTypeProtocol {
    
    var presenter: InteractorToPresenterMedicineTypeProtocol? { get set }
    func registerNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView)
    func loadData()
    func setUptittleAndLbl(noteLbl: UILabel, nextBtn: UIButton, tableView: UITableView)
    func cellForRow(tableView: UITableView, arrMedicine: [medicineType], selectedIndex: Int, indexPath: IndexPath, nextBtn: UIButton) -> UITableViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMedicineTypeProtocol {
    func showDataSuccessfully(arrMedicineType: [medicineType])
    func showSelectedIndexType(selectedIndexType: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMedicineTypeProtocol {
    func pushToVC(medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicineLbl: UILabel, navigationController: UINavigationController)
    func pushTo(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
