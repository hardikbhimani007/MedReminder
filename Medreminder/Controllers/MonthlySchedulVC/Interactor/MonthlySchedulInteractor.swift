//
//  MonthlySchedulInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MonthlySchedulInteractor: PresenterToInteractorMonthlySchedulProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMonthlySchedulProtocol?
    
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: "MedicineTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineTypeTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func loadDataInView() {
        let data1 = MedicineSchedul(time: "\(localized(key: "Daliy"))")
        let data2 = MedicineSchedul(time: "\(localized(key: "Once a week"))")
        let data3 = MedicineSchedul(time: "\(localized(key: "2 days a week"))")
        let data4 = MedicineSchedul(time: "\(localized(key: "3 days a week"))")
        let data5 = MedicineSchedul(time: "\(localized(key: "4 days a week"))")
        let data6 = MedicineSchedul(time: "\(localized(key: "5 days a week"))")
        let data7 = MedicineSchedul(time: "\(localized(key: "6 days a week"))")
        let data8 = MedicineSchedul(time: "\(localized(key: "Once a month"))")
        let data9 = MedicineSchedul(time: "\(localized(key: "Alternate days"))")
        presenter?.loadDatasucessfully(arrSchedule: [data1, data2, data3, data4, data5, data6, data7, data8, data9])
    }
    
    func cellFor(tableView: UITableView, arrSchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrSchedule[indexPath.row]
        cell.MedicineType.text = type.time
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            nextBtn.isHidden = false
        } else {
            cell.selectionBtn.isSelected = false
        }
        presenter?.setIndexSuccessfully(index: selectedIndex)
         return cell
    }
    
    func setTittleAndBtn(questionLbl: UILabel, nextBtn: UIButton, tableView: UITableView) {
        questionLbl.text = "\(localized(key: "How often do you take this medicine?"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableView.reloadData()
    }
}
