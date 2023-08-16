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
    // MARK: - Properties
    var presenter: ViewToPresenterTakeMedicineProtocol?
    var index: Int?
    var isUpdate: Bool?
    let objMed: MedDetalis? = nil
    var medName = ""
    var medType = ""
    var med1 = ""
    var firstDose = ""
    var hr = 0
    var min = 0
    var sec = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TakeMedicineRouter.createModule(vc: self)
        takeView.layer.cornerRadius = 10
        takeBtn.layer.cornerRadius = 29
        editBtn.layer.cornerRadius = 29
        presenter?.localNotification(med1: med1, medName: medName, medType: medType, firstDose: firstDose, medNameLbl: medNameLbl, medTypeLbl: medTypeLbl, schedulLbl: schedulLbl, timeLbl: timeLbl, hr: hr, min: min)
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
        editBtn.addTarget(self, action: #selector(tappedEditBtn), for: .touchUpInside)
    }
    
    //MARK: - Functions
    func deleteDataFromDataBase() {
        presenter?.deleteDataFromDatabase(index: index ?? 0)
    }
    
    func setRootView() {
        presenter?.showRootView()
    }
    //MARK: - Button Actions
    @objc func tappedCancelBtn() {
        setRootView()
    }
    
    @objc func tappedEditBtn() {
        presenter?.showToVC(index: index, navigationController: navigationController!)
    }
    
    @IBAction func tappedDeleteBtn(_ sender: UIButton) {
        deleteDataFromDataBase()
        setRootView()
    }
    
    @IBAction func tappedTakeBtn(_ sender: UIButton) {
        deleteDataFromDataBase()
        setRootView()
    }
}

extension TakeMedicineVC: PresenterToViewTakeMedicineProtocol{
    // TODO: Implement View Output Methods
}
