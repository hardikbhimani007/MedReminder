//
//  MedicinePurposeVC.swift
//  Medreminder
//
//  Created by MacOS on 31/07/2023.
//

import UIKit
import Alamofire

class MedicinePurposeVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var medicinePurposeTitle: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var txtFieldView: UIView!
    @IBOutlet weak var txtFieldChooseReason: UITextField!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var tableViewMedPurpose: UITableView!
    // MARK: - Properties
    var presenter: ViewToPresenterMedicinePurposeProtocol?
    var medicinePurpose = Medicine()
    var arrMedPupose = [MedicineName]()
    var filterMed = [MedicineName]()
    var getStrength = ""
    var filtered = false
    var objMedicne: MedDetalis?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicinePurposeRouter.createModule(vc: self)
        medicinePurposeSetUp()
        getData()
        presenter?.showRegisterNib(nibName: "MedicineNameTableViewCell", forCellReuseIdentifier: "MedicineNameTableViewCell", tableView: tableViewMedPurpose)
        presenter?.showLoadedAPI(tableView: tableViewMedPurpose)
        txtFieldChooseReason.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.btnAndLabel(questionLbl: questionLbl, noteLbl: noteLbl, nextBtn: nextBtn)
    }
    //MARK: - Functions
    func getData() {
        medicinePurposeTitle.text = medicinePurpose.medicineName
    }
    
    private func medicinePurposeSetUp() {
        presenter?.titleFieldAndBtn(txtFieldView: txtFieldView, txtField: txtFieldChooseReason, nextBtn: nextBtn)
        txtFieldChooseReason.addTarget(self, action: #selector(textViewDidChange(_:)), for: UIControl.Event.editingChanged)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
     }
    //MARK: - Button Actions
    @objc  func textViewDidChange(_ textView: UITextView) {
        presenter?.showTxtViewDidChange(nextBtn: nextBtn, tableView: tableViewMedPurpose, txtField: txtFieldChooseReason, noteLbl: noteLbl)
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedNextBtn() {
        presenter?.showToVCWithData(txtField: medicinePurposeTitle, medName: objMedicne?.medName ?? "", medType: objMedicne?.medType ?? "", firstDose: objMedicne?.firstDose ?? "", hr: objMedicne?.hr ?? 0, min: objMedicne?.min ?? 0, sec: objMedicne?.sec ?? 0, isUpdate: objMedicne?.isEdit ?? false, index: objMedicne?.index ?? 0, navigationController: navigationController!)
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
extension MedicinePurposeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.setNumberOfRowSection(filterMed: filterMed, arrMedPupose: arrMedPupose, filtered: filtered) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.setCellForRow(tableView: tableView, filterMed: filterMed, arrMedPupose: arrMedPupose, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didselectRowAT(filterMed: filterMed, arrMedPupose: arrMedPupose, txtField: txtFieldChooseReason, nextBtn: nextBtn, indexPath: indexPath)
    }
}
//MARK: - UITextFieldDelegate
extension MedicinePurposeVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let txtFiled = txtFieldChooseReason.text {
            filterText(txtFiled + string)
        }
        return true
    }
    
    func filterText(_ query: String) {
        filterMed.removeAll()
        for string in arrMedPupose {
            if string.term.lowercased().starts(with: query.lowercased()) {
                filterMed.append(string)
            }
            tableViewMedPurpose.reloadData()
            filtered = true
        }
    }
}

extension MedicinePurposeVC: PresenterToViewMedicinePurposeProtocol{
    // TODO: Implement View Output Methods
    func showData(arrMedPupose: [MedicineName]) {
        self.arrMedPupose = arrMedPupose
        self.tableViewMedPurpose.reloadData()
    }
}
