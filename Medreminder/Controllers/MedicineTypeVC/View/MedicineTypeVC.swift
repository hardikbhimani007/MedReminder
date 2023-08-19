//
//  MedicineTypeVC.swift
//  Medreminder
//
//  Created by MacOS on 28/07/2023.
//

import UIKit
import RealmSwift

class MedicineTypeVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var medicineNameLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var tableViewMedicineType: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    // MARK: - Properties
    var presenter: ViewToPresenterMedicineTypeProtocol?
    var medicine = Medicine()
    var arrMedicine = [medicineType]()
    var selectedIndex = 0
    var selectedIndexType = ""
    var objMedicine: MedDetalis?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicineTypeRouter.createModule(vc: self)
        getDataFrom()
        presenter?.showRegisterNib(nibName: "MedicineTypeTableViewCell", forCellReuseIdentifier: "MedicineTypeTableViewCell", tableView: tableViewMedicineType)
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showLoadedData()
        presenter?.showtittleAndLbl(noteLbl: noteLbl, nextBtn: nextBtn, tableView: tableViewMedicineType)
    }
    //MARK: - Functions
    func getDataFrom() {
        medicineNameLbl.text = medicine.medicineName
    }

    //MARK: - Button Actions
    @objc func tappedNextBtn() {
        presenter?.storeValueWithPush(medName: objMedicine?.medName ?? "", medType: objMedicine?.medType ?? "", firstDose: objMedicine?.firstDose ?? "", hr: objMedicine?.hr ?? 0, min: objMedicine?.min ?? 0, sec: objMedicine?.sec ?? 0, isUpdate: objMedicine?.isEdit ?? false, index: objMedicine?.index ?? 0, medicineLbl: medicineNameLbl, navigationController: navigationController!)
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedVolumeBtn() {
        presenter?.showVC(storyBoardName: "Home", withIdentifier: "SoundVC", navigationController: navigationController!)
    }
    
    @objc func tappedDocumnetBtn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController?.view.layer.add(transition, forKey: nil)
        presenter?.showVC(storyBoardName: "Home", withIdentifier: "SideMenuViewController", navigationController: navigationController!)
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension MedicineTypeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedicine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = arrMedicine.firstIndex(where: { $0.nameAndStrength == (objMedicine?.medType ?? "") }) {
            return presenter?.showCellForRow(tableView: tableView, arrMedicine: arrMedicine, selectedIndex: index, indexPath: indexPath, nextBtn: nextBtn) ?? UITableViewCell()
        } else {
            return presenter?.showCellForRow(tableView: tableView, arrMedicine: arrMedicine, selectedIndex: selectedIndex, indexPath: indexPath, nextBtn: nextBtn) ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}

extension MedicineTypeVC: PresenterToViewMedicineTypeProtocol{
    // TODO: Implement View Output Methods
    func showData(arrMedicineType: [medicineType]) {
        self.arrMedicine = arrMedicineType
        self.tableViewMedicineType.reloadData()
    }
    
    func showSelectedIndexType(selectedIndexType: String) {
        self.selectedIndexType = selectedIndexType
    }
}
