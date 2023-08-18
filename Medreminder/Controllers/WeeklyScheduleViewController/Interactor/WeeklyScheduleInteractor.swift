//
//  WeeklyScheduleInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class WeeklyScheduleInteractor: PresenterToInteractorWeeklyScheduleProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterWeeklyScheduleProtocol?
    
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func loadData() {
        let data1 = MedicineSchedul(time: "\(localized(key: "Sunday"))")
        let data2 = MedicineSchedul(time: "\(localized(key: "Monday"))")
        let data3 = MedicineSchedul(time: "\(localized(key: "Tuesday"))")
        let data4 = MedicineSchedul(time: "\(localized(key: "Wednesday"))")
        let data5 = MedicineSchedul(time: "\(localized(key: "Thursday"))")
        let data6 = MedicineSchedul(time: "\(localized(key: "Friday"))")
        let data7 = MedicineSchedul(time: "\(localized(key: "Saturday"))")
        presenter?.showDataSuccessfully(arrDaySchedule: [data1, data2, data3, data4, data5, data6, data7])
    }
    
    func setLblAndBtn(questionLbl: UILabel, nextBtn: UIButton, tableview: UITableView) {
        questionLbl.text = "\(localized(key: "Choose the days you need to take the med"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableview.reloadData()
    }
    
    func cellFor(tableView: UITableView, arrDaySchedule: [MedicineSchedul], selectedIndex: [Int], nextBtn: UIButton, indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrDaySchedule[indexPath.row]
        cell.MedicineType.text = type.time
            if selectedIndex.contains(indexPath.row) {
                cell.selectionBtn.isSelected = true
            } else {
                cell.selectionBtn.isSelected = false
            }
         return cell
    }
}
