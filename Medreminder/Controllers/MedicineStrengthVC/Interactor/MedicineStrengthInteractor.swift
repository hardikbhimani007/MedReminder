//
//  MedicineStrengthInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class MedicineStrengthInteractor: PresenterToInteractorMedicineStrengthProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMedicineStrengthProtocol?
    
    func setTxtFieldAndBtn(txtField: UITextField, nextBtn: UIButton) {
        txtField.layer.cornerRadius = 22.5
        txtField.borderStyle = .none
        txtField.layer.borderColor = UIColor.cyan.cgColor
        txtField.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 22.5
    }
    
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func setTittleLblAndBtn(noteLbl: UILabel, tittleLbl: UILabel, nextBtn: UIButton, tableView: UITableView) {
        noteLbl.text = "\(localized(key: "What strength is the medicine?"))"
        tittleLbl.text = "\(localized(key: "Type"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableView.reloadData()
    }
    
    func loadData() {
        let type1 = medicineType(nameAndStrength: "\(localized(key: "g"))")
        let type2 = medicineType(nameAndStrength: "\(localized(key: "IU"))")
        let type3 = medicineType(nameAndStrength: "\(localized(key: "mcg"))")
        let type4 = medicineType(nameAndStrength: "\(localized(key: "mEq"))")
        let type5 = medicineType(nameAndStrength: "\(localized(key: "mg"))")
        presenter?.loadDataSuceessfully(arrStregth: [type1, type2, type3, type4, type5])
    }
    
    func txtViewDidChange(nextBtn: UIButton, txtField: UITextField, tittleLbl: UILabel) {
        nextBtn.isHidden = true
        if txtField.text!.isEmpty {
            tittleLbl.isHidden = false
        } else {
            tittleLbl.isHidden = true
            nextBtn.isHidden = false
        }
    }
    
    func cellForRow(tableView: UITableView, indexPath: IndexPath, arrStrength: [medicineType], selectedIndex: Int) -> UITableViewCell {
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrStrength[indexPath.row]
        cell.MedicineType.text = type.nameAndStrength
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            let getStrength = cell.MedicineType.text!
            presenter?.showGetStrengthSucessfully(getStrength: getStrength)
        } else {
            cell.selectionBtn.isSelected = false
        }
        return cell
    }
}
