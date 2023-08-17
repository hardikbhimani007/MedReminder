//
//  SetTimerInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit
import RealmSwift
import UserNotifications

class SetTimerInteractor: PresenterToInteractorSetTimerProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterSetTimerProtocol?
    
    func setBtn(nextBtn: UIButton, updateBtn: UIButton) {
        nextBtn.layer.cornerRadius = 22.5
        updateBtn.layer.cornerRadius = 22.5
    }
    
    func setUpLblsAndBtn(hrLbl: UILabel, minLbl: UILabel, secLbl: UILabel, setTimeLbl: UILabel, nextBtn: UIButton) {
        hrLbl.text = "\(localized(key: "Hours"))"
        minLbl.text = "\(localized(key: "Minutes"))"
        secLbl.text = "\(localized(key: "Seconds"))"
        setTimeLbl.text = "\(localized(key: "Set Time"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Done"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
    }
    
    func setLocalNotification(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        let notificationIdentifier = UUID().uuidString
        var dateComponet = DateComponents()
        content.title = "Notification on a certail date"
        content.body = "This is a local notification on certain date"
        content.sound = .default
        content.userInfo = ["MedName": "\(objMedicine?.medName ?? "")",
                            "MedType": "\(objMedicine?.medType ?? "")",
                            "FirstDose": "\(objMedicine?.firstDose ?? "")",
                            "hr": hour,
                            "Min": minute,
                            "Sec": second
        ]
        dateComponet.hour = hour
        dateComponet.minute = minute
        dateComponet.second = second
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponet, repeats: false)
        let request =   UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
    
    func addDataFromDatabase(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?) {
        let realm = try! Realm()
        print(">>>>>>>",Realm.Configuration.defaultConfiguration.fileURL)
        let detalis = MedicineDetalis()
        var med = objMedicine
        med?.hr = hour
        med?.min = minute
        med?.sec = second

        detalis.medicineName = med?.medName
        detalis.medicineType = med?.medType
        detalis.firstDose = med?.firstDose
        detalis.hr = med?.hr
        detalis.min = med?.min
        detalis.sec = med?.sec

        try! realm.write({
            realm.add(detalis)
        })
    }
}
