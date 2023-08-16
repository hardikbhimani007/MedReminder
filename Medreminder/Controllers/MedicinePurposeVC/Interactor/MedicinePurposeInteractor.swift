//
//  MedicinePurposeInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import Alamofire

class MedicinePurposeInteractor: PresenterToInteractorMedicinePurposeProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMedicinePurposeProtocol?
    
    func setTitleFieldAndBtn(txtFieldView: UIView, txtField: UITextField, nextBtn: UIButton) {
        txtFieldView.layer.cornerRadius = 22.5
        txtField.borderStyle = .none
        txtFieldView.layer.borderColor = UIColor.cyan.cgColor
        txtFieldView.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 25
    }
    
    func loadAPI(tableView: UITableView) {
        guard let url = URL(string: "https://api.fda.gov/drug/label.json?count=openfda.brand_name.exact&limit=500") else { return }
        AF.request(url).responseDecodable(of: MedicineResponse.self) { [self] response in
            guard let medResponse = response.value else { return }
            let data = medResponse.results
            presenter?.showDataSucessfully(arrMedPupose: data)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func registerNib(nibName: String, forCellReuseIdentifier: String, tableView: UITableView) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func setBtnAndLabel(questionLbl: UILabel, noteLbl: UILabel, nextBtn: UIButton) {
        questionLbl.text = "\(localized(key: "What is the purpose for taking this medication?"))"
        noteLbl.text = "\(localized(key: "Type and choose the reason from the list"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
    }
    
    func txtViewDidChange(nextBtn: UIButton, tableView: UITableView, txtField: UITextField, noteLbl: UILabel) {
        nextBtn.isHidden = true
        tableView.isHidden = true
        if txtField.text!.isEmpty {
            noteLbl.isHidden = false
            tableView.isHidden = true
        } else {
            noteLbl.isHidden = true
            nextBtn.isHidden = false
            tableView.isHidden = false
        }
    }
    
    func numberOfRowSection(filterMed: [MedicineName], arrMedPupose: [MedicineName], filtered: Bool) -> Int {
        if !filterMed.isEmpty {
            return filterMed.count
        }
        return filtered ? 0 : arrMedPupose.count
    }
    
    func cellForRow(tableView: UITableView, filterMed: [MedicineName], arrMedPupose: [MedicineName], indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineNameTableViewCell") as! MedicineNameTableViewCell
        if !filterMed.isEmpty {
            cell.medNameLbl.text = filterMed[indexPath.row].term
        } else {
            cell.medNameLbl.text = arrMedPupose[indexPath.row].term
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func didselect(filterMed: [MedicineName], arrMedPupose: [MedicineName], txtField: UITextField, nextBtn: UIButton, indexPath: IndexPath) {
        if !filterMed.isEmpty {
            txtField.text = filterMed[indexPath.row].term
            nextBtn.isHidden = false
        } else {
            txtField.text = arrMedPupose[indexPath.row].term
            nextBtn.isHidden = false
        }
    }
}
