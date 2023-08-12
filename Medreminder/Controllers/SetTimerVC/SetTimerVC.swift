//
//  SetTimerVC.swift
//  Medreminder
//
//  Created by MacOS on 31/07/2023.
//

import UIKit
import RealmSwift
import UserNotifications

class SetTimerVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var medicineTitleLbl: UILabel!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var setTimeLbl: UILabel!
    @IBOutlet weak var hrLbl: UILabel!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var secLbl: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    //MARK: - Properties
    var shouldShowUpdateButton = false
    let realm = try! Realm()
    var medicinePurpose = Medicine()
    var objMedicine: MedDetalis?
    var formatter = ""
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        nextBtn.layer.cornerRadius = 22.5
        updateBtn.layer.cornerRadius = 22.5
        timePicker.delegate = self
        nextBtn.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
        BackBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
        updateBtn.addTarget(self, action: #selector(tappedUpdateBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hrLbl.text = "\(localized(key: "Hours"))"
        minLbl.text = "\(localized(key: "Minutes"))"
        secLbl.text = "\(localized(key: "Seconds"))"
        setTimeLbl.text = "\(localized(key: "Set Time"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Done"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        setButtons()
    }
    //MARK: - Functions
    func setButtons() {
        nextBtn.isHidden = objMedicine?.isEdit ?? true
        updateBtn.isHidden = !(objMedicine?.isEdit ?? false)
    }
    
    func setLocalNotification() {
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
    
    func getData() {
        medicineTitleLbl.text = medicinePurpose.medicineName
    }
    
    func addDataFromDatabase() {
        print(">>>>>>>",Realm.Configuration.defaultConfiguration.fileURL)
        let detalis = MedicineDetalis()
        objMedicine?.hr = hour
        objMedicine?.min = minute
        objMedicine?.sec = second
        
        detalis.medicineName = objMedicine?.medName
        detalis.medicineType = objMedicine?.medType
        detalis.firstDose = objMedicine?.firstDose
        detalis.hr = objMedicine?.hr
        detalis.min = objMedicine?.min
        detalis.sec = objMedicine?.sec
        
        try! realm.write({
            realm.add(detalis)
        })
    }
    
    func formatTime() -> String {
        let hourString = String(format: "%02d", hour)
        let minuteString = String(format: "%02d", minute)
        let secondString = String(format: "%02d", second)
        return "\(hourString):\(minuteString):\(secondString)"
    }
    //MARK: - Button Actions
    @objc func tappedDoneButton() {
        setLocalNotification()
        self.addDataFromDatabase()
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedVolumeBtn() {
        let vc = UIStoryboard(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "SoundVC") as! SoundVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedDocumnetBtn() {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedUpdateBtn() {
         try! realm.write({
             let update = realm.objects(MedicineDetalis.self)[objMedicine?.index ?? 0]
             update.medicineName = objMedicine?.medName
             update.medicineType = objMedicine?.medType
             update.firstDose = objMedicine?.firstDose
             update.hr = hour
             update.min = minute
             update.sec = second
         })
        self.navigationController?.popToRootViewController(animated: true)
     }
}
//MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension SetTimerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1,2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return timePicker.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) "
        case 1:
            return "\(row) "
        case 2:
            return "\(row) "
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            nextBtn.isHidden = false
            return hour = row
        case 1:
            nextBtn.isHidden = false
            return minute = row
        case 2:
            nextBtn.isHidden = false
            return second = row
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {
            label.textColor = UIColor(red: 0.384, green: 0.957, blue: 0.957, alpha: 1)
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
        
        switch component {
        case 0:
            label.text = String(format: "%02d", row,   ":")
        case 1,2:
            label.text = String(format: "%02d", row)
        default:
            break
        }
        return label
    }
}
