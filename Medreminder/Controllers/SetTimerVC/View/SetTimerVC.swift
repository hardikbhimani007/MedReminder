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
    
    // MARK: - Properties
    var presenter: ViewToPresenterSetTimerProtocol?
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
        SetTimerRouter.createModule(vc: self)
        getData()
        presenter?.showBtn(nextBtn: nextBtn, updateBtn: updateBtn)
        timePicker.delegate = self
        nextBtn.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
        BackBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
        updateBtn.addTarget(self, action: #selector(tappedUpdateBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showLblsAndBtn(hrLbl: hrLbl, minLbl: minLbl, secLbl: secLbl, setTimeLbl: setTimeLbl, nextBtn: nextBtn)
        setButtons()
    }
    //MARK: - Functions
    func setButtons() {
        nextBtn.isHidden = objMedicine?.isEdit ?? true
        updateBtn.isHidden = !(objMedicine?.isEdit ?? false)
    }
    
    func getData() {
        medicineTitleLbl.text = medicinePurpose.medicineName
    }
    
    func formatTime() -> String {
        let hourString = String(format: "%02d", hour)
        let minuteString = String(format: "%02d", minute)
        let secondString = String(format: "%02d", second)
        return "\(hourString):\(minuteString):\(secondString)"
    }
    //MARK: - Button Actions
    @objc func tappedDoneButton() {
        presenter?.showLocalNotification(hour: hour, minute: minute, second: second, objMedicine: objMedicine)
        presenter?.addDataFrom(hour: hour, minute: minute, second: second, objMedicine: objMedicine)
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedVolumeBtn() {
        presenter?.showToVC(storyBoardName: "Home", withIdentifier: "SoundVC", navigationController: navigationController!)
    }
    
    @objc func tappedDocumnetBtn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController!.view.layer.add(transition, forKey: nil)
        presenter?.showToVC(storyBoardName: "Home", withIdentifier: "SideMenuViewController", navigationController: navigationController!)
    }
    
    @objc func tappedUpdateBtn() {
        presenter?.updateData(objMedicine: objMedicine, hour: hour, minute: minute, second: second, navigationController: navigationController!)
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

extension SetTimerVC: PresenterToViewSetTimerProtocol{
    // TODO: Implement View Output Methods
    func showTime(objMedicine: MedDetalis?) {
        self.objMedicine = objMedicine
    }
}
