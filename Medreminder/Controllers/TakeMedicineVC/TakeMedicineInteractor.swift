//
//  TakeMedicineInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import RealmSwift

class TakeMedicineInteractor: PresenterToInteractorTakeMedicineProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterTakeMedicineProtocol?
    
    func deleteData(index: Int?) {
        let realm = try! Realm()
        let deleteData = realm.objects(MedicineDetalis.self)[index ?? 0]
        try! realm.write({
            realm.delete(deleteData)
        })
    }
    
    func setUpLocalNotification(med1: String, medName: String, medType: String, firstDose: String, medNameLbl: UILabel, medTypeLbl: UILabel, schedulLbl: UILabel, timeLbl: UILabel, hr: Int, min: Int) {
        var med1 = med1
        med1 = "1 \(medType)"
        medNameLbl.text = medName
        medTypeLbl.text = med1
        schedulLbl.text = firstDose
        let ampm = hr >= 12 ? "PM" : "AM"
        let formatedTime = String(format: "%02d:%02d %@", hr, min, ampm)
        timeLbl.text = formatedTime
    }
}
