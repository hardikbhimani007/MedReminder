//
//  AddMedicationInteractor.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import Alamofire

class AddMedicationInteractor: PresenterToInteractorAddMedicationProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterAddMedicationProtocol?
    
    func setUptittle(nextBtn: UIButton, questionLbl: UILabel, noteLbl: UILabel) {
        questionLbl.text = localized(key: "What medicine do you want to add?")
        noteLbl.text = "\(localized(key: "Type of choose your med from the list"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
    }
    
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func loadData(tableView: UITableView) {
        guard let url = URL(string: "https://api.fda.gov/drug/label.json?count=openfda.brand_name.exact&limit=500") else { return }
        AF.request(url).responseDecodable(of: MedicineResponse.self) { [self] response in
            guard let medResponse = response.value else { return }
            let arrMed = medResponse.results
            presenter?.showDataSuccessfully(arrMedName: arrMed)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func setUpTxtField(txtFieldView: UIView, txtFieldName: UITextField, nextBtn: UIButton) {
        txtFieldView.layer.cornerRadius = 22.5
        txtFieldView.layer.borderColor = UIColor.cyan.cgColor
        txtFieldView.layer.borderWidth = 1
        txtFieldName.borderStyle = .none
        nextBtn.layer.cornerRadius = 25
    }
    
    func txtViewDidChange(nextBtn: UIButton, tableView: UITableView, noteLbl: UILabel, txtFieldName: UITextField) {
        nextBtn.isHidden = true
        tableView.isHidden = true
        if txtFieldName.text!.isEmpty {
            noteLbl.isHidden = false
            tableView.isHidden = true
        } else {
            noteLbl.isHidden = true
            nextBtn.isHidden = false
            tableView.isHidden = false
        }
    }
    
    func loadFilterData(filterMed: [MedicineName], medArray: [MedicineName], filtered: Bool) -> Int{
        if !filterMed.isEmpty {
            return filterMed.count
        }
        return filtered ? 0 : medArray.count
    }
    
    func showFilteredDataInTableView(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineNameTableViewCell") as! MedicineNameTableViewCell
        if !filterMed.isEmpty {
            cell.medNameLbl.text = filterMed[indexPath.row].term
        } else {
            cell.medNameLbl.text = medArray[indexPath.row].term
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func didSelect(tableView: UITableView, filterMed: [MedicineName], medArray: [MedicineName], indexPath: IndexPath, nextBtn: UIButton, txtFiledName: UITextField) {
        if !filterMed.isEmpty {
            txtFiledName.text = filterMed[indexPath.row].term
            nextBtn.isHidden = false
        } else {
            txtFiledName.text = medArray[indexPath.row].term
            nextBtn.isHidden = false
        }
    }
}
