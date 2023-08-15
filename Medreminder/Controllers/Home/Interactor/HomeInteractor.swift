//
//  HomeInteractor.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import RealmSwift
import FSCalendar

class HomeInteractor: PresenterToInteractorHomeProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterHomeProtocol?
    
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
    
    func setAlertHasLunchedBefore(names: String ,tableView: UITableView, vc: HomeVC) {
        presenter?.fetchingPopUp(names: names,tableView: tableView, vc: vc)
    }
    
    func registerNib(tableView: UITableView, nibName: String, nibName2: String, forHeaderFooterViewReuseIdentifier: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: forHeaderFooterViewReuseIdentifier)
        tableView.register(UINib(nibName: nibName2, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
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
    
    func setHeaderView(tableView: UITableView) -> UIView {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        let hour = Calendar.current.component(.hour, from: Date())
        header.userNameLbl.text = UserDefaults.standard.string(forKey: "name")
        header.userBtn.setTitle(UserDefaults.standard.string(forKey: "name"), for: .normal)
        switch hour {
        case 6..<12 :
            header.goodMoringLbl.text = "\(localized(key: "Good Morning"))"
        case 12..<17 :
            header.goodMoringLbl.text = "\(localized(key: "Good Afternoon"))"
        case 17..<22 :
            header.goodMoringLbl.text = "\(localized(key: "Good Evening"))"
        default:
            header.goodMoringLbl.text = "\(localized(key: "Good Night"))"
        }
        header.userBtn.layer.cornerRadius = 10
        header.userBtn.contentHorizontalAlignment = .left
        return header
    }
}
