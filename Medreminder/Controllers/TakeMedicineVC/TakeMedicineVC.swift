//
//  TakeMedicineVC.swift
//  Medreminder
//
//  Created by MacOS on 03/08/2023.
//

import UIKit
import UserNotifications
import RealmSwift

class TakeMedicineVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var takeView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var medNameLbl: UILabel!
    @IBOutlet weak var medTypeLbl: UILabel!
    @IBOutlet weak var schedulLbl: UILabel!
    @IBOutlet weak var takeBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var DeleteBtn: UIButton!
    //MARK: - Properties
    let realm = try! Realm()
    let homeVC = HomeVC()
    var data: GetData = GetData()
    var medName = ""
    var medType = ""
    var med1 = ""
    var firstDose = ""
    var hr = 0
    var min = 0
    var sec = 0
    var formatedTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takeView.layer.cornerRadius = 10
        takeBtn.layer.cornerRadius = 29
        editBtn.layer.cornerRadius = 29
        setUpNotificationData()
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
        takeBtn.addTarget(self, action: #selector(tappedTakeBtn), for: .touchUpInside)
        editBtn.addTarget(self, action: #selector(tappedEditBtn), for: .touchUpInside)
    }
    
    //MARK: - Functions
    func setUpNotificationData() {
        med1 = "1 \(medType)"
        medNameLbl.text = medName
        medTypeLbl.text = med1
        schedulLbl.text = firstDose
        let ampm = hr >= 12 ? "PM" : "AM"
        formatedTime = String(format: "%02d:%02d %@", hr, min, ampm)
        timeLbl.text = formatedTime
    }

    func deleteDataFromDataBase() {
        let deleteData = realm.objects(MedicineDetalis.self)[data.index ?? 0]
        try! realm.write({
            realm.delete(deleteData)
        })
    }
    //MARK: - Button Actions
    @objc func tappedCancelBtn() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: nextViewController) // set RootViewController
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = false
        APP_DELEGATE.window?.makeKeyAndVisible()
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
    }
    
    @objc func tappedEditBtn() {
        print("Working on r_dev branch.")
        print("Working on conflict practices.")
        let update = realm.objects(MedicineDetalis.self)[data.index ?? 0]
        try! realm.write({
            
        })
//        try! realm.write({
//            let storyBoard = UIStoryboard(name: "AddMedication", bundle: nil).instantiateViewController(withIdentifier: "AddMedicationVC") as! AddMedicationVC
//            self.navigationController?.pushViewController(storyBoard, animated: true)
//        })
    }
    
    @objc func tappedTakeBtn() {
      
    }
    
    @IBAction func tappedDeleteBtn(_ sender: UIButton) {
        deleteDataFromDataBase()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: nextViewController) // set RootViewController
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = false
        APP_DELEGATE.window?.makeKeyAndVisible()
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
    }
}

