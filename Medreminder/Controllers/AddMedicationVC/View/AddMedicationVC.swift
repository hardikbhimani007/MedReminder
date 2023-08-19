//
//  AddMedicationVC.swift
//  Medreminder
//
//  Created by MacOS on 28/07/2023.
//

import UIKit
import Alamofire
import RealmSwift

class AddMedicationVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var txtFieldView: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var txtFieldMedicineName: UITextField!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var tableviewMedName: UITableView!
    
    // MARK: - Properties
    var presenter: ViewToPresenterAddMedicationProtocol?
    var medArray = [MedicineName]()
    var filterMed = [MedicineName]()
    var objMedicine: MedDetalis?
    var filtered = false
    var isUpdate = false
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddMedicationRouter.createModule(vc: self)
        setUp()
        titleLbl.text = "AddMedication"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        presenter?.showTittle(nextBtn: nextBtn, questionLbl: questionLbl, noteLbl: noteLbl)
    }
    //MARK: - Functions
    func setUp() {
        addMedicationSetUp()
        presenter?.fetchRegisterNib(tableView: tableviewMedName, nibName: "MedicineNameTableViewCell", forCellReuseIdentifier: "MedicineNameTableViewCell")
        presenter?.loadData(tableView: tableviewMedName)
        txtFieldMedicineName.delegate = self
    }
    
    func getData() {
        presenter?.getData(isUpdate: isUpdate, tittleLbl: titleLbl, txtField: txtFieldMedicineName, nextBtn: nextBtn, objMedicine: objMedicine)
    }
    
    private func addMedicationSetUp() {
        presenter?.showTxtField(txtFieldView: txtFieldView, txtFieldName: txtFieldMedicineName, nextBtn: nextBtn)
        txtFieldMedicineName.addTarget(self, action: #selector(textViewDidChange(_:)), for: UIControl.Event.editingChanged)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    //MARK: - Button Actions
    @objc  func textViewDidChange(_ textView: UITextView) {
        presenter?.txtViewShowChange(nextBtn: nextBtn, tableView: tableviewMedName, noteLbl: noteLbl, txtFieldName: txtFieldMedicineName)
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedNextBtn() {
        presenter?.nextBtnAction(txtFieldName: txtFieldMedicineName, medType: objMedicine?.medType ?? "", firstDose: objMedicine?.firstDose ?? "", hr: objMedicine?.hr ?? 0, min: objMedicine?.min ?? 0, sec: objMedicine?.sec ?? 0, isUpdate: objMedicine?.isEdit ?? false, index: index ?? 0, navigationController: navigationController!)
    }
    
    @objc func tappedVolumeBtn() {
        presenter?.showVC(stroyBoardName: "Home", withIdentifier: "SoundVC", navigationController: navigationController!)
    }
    
    @objc func tappedDocumnetBtn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController!.view.layer.add(transition, forKey: nil)
        presenter?.showVC(stroyBoardName: "Home", withIdentifier: "SideMenuViewController", navigationController: navigationController!)
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension AddMedicationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.showFilteredData(filterMed: filterMed, medArray: medArray, filtered: filtered) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.showFilteredDataInTableView(tableView: tableView, filterMed: filterMed, medArray: medArray, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDidSelect(tableView: tableView, filterMed: filterMed, medArray: medArray, indexPath: indexPath, nextBtn: nextBtn, txtFiledName: txtFieldMedicineName)
    }
}
//MARK: - UITextFieldDelegate
extension AddMedicationVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let txtFiled = txtFieldMedicineName.text {
            filterText(txtFiled + string)
        }
        return true
    }
    
    func filterText(_ query: String) {
        filterMed.removeAll()
        for string in medArray {
            if string.term.lowercased().starts(with: query.lowercased()) {
                filterMed.append(string)
            }
            tableviewMedName.reloadData()
            filtered = true
        }
    }
}

extension AddMedicationVC: PresenterToViewAddMedicationProtocol{
    // TODO: Implement View Output Methods
    func showData(arrMedName: [MedicineName]) {
        self.medArray = arrMedName
        self.tableviewMedName.reloadData()
    }
}
