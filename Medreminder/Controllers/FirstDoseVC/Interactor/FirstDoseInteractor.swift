//
//  FirstDoseInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import RealmSwift

class FirstDoseInteractor: PresenterToInteractorFirstDoseProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterFirstDoseProtocol?
    
    func registerNib(collectionView: UICollectionView, nibName: String, forCellWithReuseIdentifier: String) {
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
    
    func loadData() {
        let data1 = MedicineSchedul(time: "\(localized(key: "Morning"))")
        let data2 = MedicineSchedul(time: "\(localized(key: "Before Food"))")
        let data3 = MedicineSchedul(time: "\(localized(key: "Afternoon"))")
        let data4 = MedicineSchedul(time: "\(localized(key: "After Food"))")
        let data5 = MedicineSchedul(time: "\(localized(key: "Evening"))")
        let data6 = MedicineSchedul(time: "\(localized(key: "Anytime"))")
        let data7 = MedicineSchedul(time: "\(localized(key: "Night"))")
        presenter?.showDataSucessfully(arrDaySchedule: [data1, data2, data3, data4, data5, data6, data7])
    }
    
    func setTittleAndBtn(questionLbl: UILabel, nextBtn: UIButton, collectionView: UICollectionView) {
        questionLbl.text = "\(localized(key: "At what time do you need your first dose?"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        collectionView.reloadData()
    }
    
    func cellForRow(collectionView: UICollectionView, arrDaySchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FirstDoseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstDoseCollectionViewCell", for: indexPath) as! FirstDoseCollectionViewCell
        cell.doseLbl.text = arrDaySchedule[indexPath.row].time
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            nextBtn.isHidden = false
            let selectedIndexType = cell.doseLbl.text!
            presenter?.showIndexSuccessfully(selectedIndexType: selectedIndexType)
        } else {
            cell.selectionBtn.isSelected = false
        }
        return cell
    }
}
