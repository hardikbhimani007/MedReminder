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
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    //MARK: - Properties
    var medicine = Medicine()
    var arrMedicine = [medicineType]()
    var selectedIndex = 0
    var selectedIndexType = ""
    var objMedicine: MedDetalis?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFrom()
        registerNib()
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        noteLbl.text = "\(localized(key: "What kind of medicine is it?"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableViewMedicineType.reloadData()
    }
    //MARK: - Functions
    func getDataFrom() {
        medicineNameLbl.text = medicine.medicineName
    }
    
    func registerNib() {
        tableViewMedicineType.register(UINib(nibName: "MedicineTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineTypeTableViewCell")
        tableViewMedicineType.separatorStyle = .none
    }
    
    func loadData() {
        let type1 = medicineType(nameAndStrength: "\(localized(key: "Pill"))")
        let type2 = medicineType(nameAndStrength: "\(localized(key: "Solution"))")
        let type3 = medicineType(nameAndStrength: "\(localized(key: "Injection"))")
        let type4 = medicineType(nameAndStrength: "\(localized(key: "Powder"))")
        let type5 = medicineType(nameAndStrength: "\(localized(key: "Drops"))")
        let type6 = medicineType(nameAndStrength: "\(localized(key: "Inhaler"))")
        let type7 = medicineType(nameAndStrength: "\(localized(key: "Other"))")
        arrMedicine = [type1, type2, type3, type4, type5, type6, type7]
    }
    //MARK: - Button Actions
    @objc func tappedNextBtn() {
        let storyBoard = UIStoryboard(name: "AddMedication", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MedicineStrengthVC") as! MedicineStrengthVC
        objMedicine = MedDetalis(medName: objMedicine?.medName ?? "", medType: selectedIndexType, firstDose: "", hr: 0, min: 0, sec: 0)
        let detalis = Medicine(medicineName: medicineNameLbl.text!)
        vc.medicine = detalis
        do {
            let data = try JSONEncoder().encode(objMedicine)
            UserDefaults.standard.set(data, forKey: "ObjMedicine")
        } catch let error {
            print("Error encoding: \(error)")
        }
        self.navigationController?.pushViewController(vc, animated: true)
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
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrMedicine[indexPath.row]
        cell.MedicineType.text = type.nameAndStrength
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            nextBtn.isHidden = false
            selectedIndexType = cell.MedicineType.text!
        } else {
            cell.selectionBtn.isSelected = false
        }
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}
