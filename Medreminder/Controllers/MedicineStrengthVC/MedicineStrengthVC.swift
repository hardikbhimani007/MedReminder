//
//  MedicineStrengthVC.swift
//  Medreminder
//
//  Created by MacOS on 28/07/2023.
//

import UIKit

class MedicineStrengthVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var txtFieldStrngth: UITextField!
    @IBOutlet weak var tableViewStrength: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var medicineNameLbl: UILabel!
    //MARK: - Properties
    var arrStregth = [medicineType]()
    var medicine = Medicine()
    var getStrength = ""
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        getDataFrom()
        registerNib()
        txtFieldStrngth.addTarget(self, action: #selector(textViewDidChange(_:)), for: UIControl.Event.editingChanged)
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        noteLbl.text = "\(localized(key: "What strength is the medicine?"))"
        titleLbl.text = "\(localized(key: "Type"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableViewStrength.reloadData()
    }
    //MARK: - Functions
    func setUP() {
        txtFieldStrngth.layer.cornerRadius = 22.5
        txtFieldStrngth.borderStyle = .none
        txtFieldStrngth.layer.borderColor = UIColor.cyan.cgColor
        txtFieldStrngth.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 22.5
    }
    
    func getDataFrom() {
        medicineNameLbl.text = medicine.medicineName
    }
    
    func registerNib() {
        tableViewStrength.register(UINib(nibName: "MedicineTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineTypeTableViewCell")
        tableViewStrength.separatorStyle = .none
    }
    
    func loadData() {
        let type1 = medicineType(nameAndStrength: "\(localized(key: "g"))")
        let type2 = medicineType(nameAndStrength: "\(localized(key: "IU"))")
        let type3 = medicineType(nameAndStrength: "\(localized(key: "mcg"))")
        let type4 = medicineType(nameAndStrength: "\(localized(key: "mEq"))")
        let type5 = medicineType(nameAndStrength: "\(localized(key: "mg"))")
        arrStregth = [type1, type2, type3, type4, type5]
    }
    //MARK: - Button Actions
    @objc  func textViewDidChange(_ textView: UITextView) {
        nextBtn.isHidden = true
        if txtFieldStrngth.text!.isEmpty {
            titleLbl.isHidden = false
        } else {
            titleLbl.isHidden = true
            nextBtn.isHidden = false
        }
    }
    
    @objc func tappedNextBtn() {
        let storyBoard = UIStoryboard(name: "MedicinePurpose", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MedicinePurposeVC") as! MedicinePurposeVC
        let detalis = Medicine(medicineName: "\(medicineNameLbl.text!), \(txtFieldStrngth.text!) \(getStrength)")
        vc.medicinePurpose = detalis
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
extension MedicineStrengthVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStregth.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrStregth[indexPath.row]
        cell.MedicineType.text = type.nameAndStrength
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            getStrength = cell.MedicineType.text!
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
