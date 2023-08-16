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
    // MARK: - Properties
    var presenter: ViewToPresenterMedicineStrengthProtocol?
    var arrStregth = [medicineType]()
    var medicine = Medicine()
    var getStrength = ""
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicineStrengthRouter.createModule(vc: self)
        getDataFrom()
        presenter?.showTxtFieldAndBtn(txtField: txtFieldStrngth, nextBtn: nextBtn)
        presenter?.showRegisterNib(tableView: tableViewStrength, nibName: "MedicineTypeTableViewCell", forCellReuseIdentifier: "MedicineTypeTableViewCell")
        txtFieldStrngth.addTarget(self, action: #selector(textViewDidChange(_:)), for: UIControl.Event.editingChanged)
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadedData()
        presenter?.tittleLblAndBtn(noteLbl: noteLbl, tittleLbl: titleLbl, nextBtn: nextBtn, tableView: tableViewStrength)
    }
    //MARK: - Functions
    func getDataFrom() {
        medicineNameLbl.text = medicine.medicineName
    }
    
    //MARK: - Button Actions
    @objc  func textViewDidChange(_ textView: UITextView) {
        presenter?.setTxtViewDidChange(nextBtn: nextBtn, txtField: txtFieldStrngth, tittleLbl: titleLbl)
    }
    
    @objc func tappedNextBtn() {
        presenter?.setNextBtn(medicineName: medicineNameLbl, txtField: txtFieldStrngth, getStrenth: getStrength, navigationController: navigationController!)
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
        presenter?.setcellForRow(tableView: tableView, indexPath: indexPath, arrStrength: arrStregth, selectedIndex: selectedIndex) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}

extension MedicineStrengthVC: PresenterToViewMedicineStrengthProtocol{
    // TODO: Implement View Output Methods
    func showData(arrStregth: [medicineType]) {
        self.arrStregth = arrStregth
        self.tableViewStrength.reloadData()
    }
    
    func showGetStrength(getStrength: String) {
        self.getStrength = getStrength
    }
}
