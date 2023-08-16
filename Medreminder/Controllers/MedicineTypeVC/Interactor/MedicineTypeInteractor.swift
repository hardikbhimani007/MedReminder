//
//  MedicineTypeInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicineTypeInteractor: PresenterToInteractorMedicineTypeProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMedicineTypeProtocol?
    
    func registerNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func loadData() {
        let type1 = medicineType(nameAndStrength: "\(localized(key: "Pill"))")
        let type2 = medicineType(nameAndStrength: "\(localized(key: "Solution"))")
        let type3 = medicineType(nameAndStrength: "\(localized(key: "Injection"))")
        let type4 = medicineType(nameAndStrength: "\(localized(key: "Powder"))")
        let type5 = medicineType(nameAndStrength: "\(localized(key: "Drops"))")
        let type6 = medicineType(nameAndStrength: "\(localized(key: "Inhaler"))")
        let type7 = medicineType(nameAndStrength: "\(localized(key: "Other"))")
        presenter?.showDataSuccessfully(arrMedicineType: [type1, type2, type3, type4, type5, type6, type7])
    }
    
    func setUptittleAndLbl(noteLbl: UILabel, nextBtn: UIButton, tableView: UITableView) {
        noteLbl.text = "\(localized(key: "What kind of medicine is it?"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableView.reloadData()
    }
    
    func cellForRow(tableView: UITableView, arrMedicine: [medicineType], selectedIndex: Int, indexPath: IndexPath, nextBtn: UIButton) -> UITableViewCell {
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrMedicine[indexPath.row]
        cell.MedicineType.text = type.nameAndStrength
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            nextBtn.isHidden = false
            let selectedIndexType = cell.MedicineType.text!
            presenter?.showSelectedIndexType(selectedIndexType: selectedIndexType)
        } else {
            cell.selectionBtn.isSelected = false
        }
        return cell
    }
}
