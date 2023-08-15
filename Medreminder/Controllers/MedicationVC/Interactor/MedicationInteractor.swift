//
//  MedicationInteractor.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import RealmSwift
import FSCalendar

class MedicationInteractor: PresenterToInteractorMedicationProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMedicationProtocol?
    
    func setUp(datePicker: FSCalendar, button: UIButton) {
        datePicker.layer.cornerRadius = 4
        button.layer.cornerRadius = 4
    }
    
    func setUpContextMenu(tittle1: String, tittle2: String, tittle3: String, addBtn: UIButton, navigationController: UINavigationController) {
        let AddMedication = UIAction(title: tittle1) { action in
            print("Medication")
            let addMedicineVC = UIStoryboard(name: "AddMedication", bundle: nil).instantiateViewController(withIdentifier: "AddMedicationVC") as! AddMedicationVC
            navigationController.pushViewController(addMedicineVC, animated: true)
        }
        let AddDose = UIAction(title: tittle2) { action in
            print("Dose")
        }
        let AddNotes = UIAction(title: tittle3) { action in
            print("Notes")
        }
        addBtn.showsMenuAsPrimaryAction = true
        addBtn.menu = UIMenu(title: "", children: [AddNotes, AddDose, AddMedication])
    }
    
    func getDataFromDataBase(tableView: UITableView) {
        let realm = try! Realm()
        let getData = Array(realm.objects(MedicineDetalis.self))
        self.presenter?.showDataSuccessfully(arrMedDetalis: getData)
        tableView.reloadData()
    }
    
    func settittleOfBtnAndLanguage(name: String, btn: UIButton) {
        let tittle = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 7.2, weight: .bold)])
        btn.setAttributedTitle(tittle, for: .normal)
    }
    
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    func tapGesture(datePickerView: FSCalendar) {
        datePickerView.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
        let scopeGesture = UIPanGestureRecognizer(target: datePickerView, action: #selector(datePickerView.handleScopeGesture(_:)))
        datePickerView.addGestureRecognizer(scopeGesture)
        datePickerView.accessibilityIdentifier = "calendar"
    }
   
    func loadDataForCell(tableView: UITableView, arrMedDtalis: [MedicineDetalis], indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineDetalisTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineDetalisTableViewCell") as! MedicineDetalisTableViewCell
        cell.MedicineNameLbl.text = arrMedDtalis[indexPath.row].medicineName
        cell.MedTypeLbl.text = arrMedDtalis[indexPath.row].medicineType
        cell.takingLbl.text = arrMedDtalis[indexPath.row].firstDose
        let ampm = arrMedDtalis[indexPath.row].hr ?? 0 >= 12 ? "PM" : "AM"
        let formatedTime = String(format: "%02d:%02d %@", arrMedDtalis[indexPath.row].hr!, arrMedDtalis[indexPath.row].min!, ampm)
        cell.timerLbl.text = formatedTime
        return cell
    }

}
