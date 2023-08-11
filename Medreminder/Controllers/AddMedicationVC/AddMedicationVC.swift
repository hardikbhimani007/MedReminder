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
    //MARK: - Properties
    var medArray = [MedicineName]()
    var filterMed = [MedicineName]()
    var filtered = false
    var isUpdate = false
    var index: Int?
    var objMedDetails: MedDetalis?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionLbl.text = localized(key: "What medicine do you want to add?")
        noteLbl.text = "\(localized(key: "Type of choose your med from the list"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
    }
    //MARK: - Functions
    func setUp() {
        addMedicationSetUp()
        registerNib()
        getData()
        txtFieldMedicineName.delegate = self
    }
    
    func getData() {
        guard let url = URL(string: "https://api.fda.gov/drug/label.json?count=openfda.brand_name.exact&limit=500") else { return }
        AF.request(url).responseDecodable(of: MedicineResponse.self) { [self] response in
            guard let medResponse = response.value else { return }
            self.medArray = medResponse.results
            DispatchQueue.main.async {
                self.tableviewMedName.reloadData()
            }
        }
    }
    
    func registerNib() {
        tableviewMedName.register(UINib(nibName: "MedicineNameTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineNameTableViewCell")
        tableviewMedName.separatorStyle = .none
    }
    
    private func addMedicationSetUp() {
        txtFieldView.layer.cornerRadius = 22.5
        txtFieldView.layer.borderColor = UIColor.cyan.cgColor
        txtFieldView.layer.borderWidth = 1
        txtFieldMedicineName.borderStyle = .none
        nextBtn.layer.cornerRadius = 25
        txtFieldMedicineName.addTarget(self, action: #selector(textViewDidChange(_:)), for: UIControl.Event.editingChanged)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    //MARK: - Button Actions
    @objc  func textViewDidChange(_ textView: UITextView) {
        nextBtn.isHidden = false
        tableviewMedName.isHidden = true
        if txtFieldMedicineName.text!.isEmpty {
            noteLbl.isHidden = false
            tableviewMedName.isHidden = true
        } else {
            noteLbl.isHidden = true
            nextBtn.isHidden = false
            tableviewMedName.isHidden = false
        }
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedNextBtn() {
        let storyBoard = UIStoryboard(name: "AddMedication", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MedicineTypeVC") as! MedicineTypeVC
        objMedDetails = MedDetalis(medName: txtFieldMedicineName.text ?? "", medType: "", firstDose: "", hr: 0, min: 0, sec: 0, isEdit: isUpdate, index: index)
        let detalis = Medicine(medicineName: txtFieldMedicineName.text!)
        vc.medicine = detalis
        vc.objMedicine = objMedDetails
        self.navigationController?.pushViewController(vc, animated: true)
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
extension AddMedicationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filterMed.isEmpty {
            return filterMed.count
        }
        return filtered ? 0 : medArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineNameTableViewCell") as! MedicineNameTableViewCell
        if !filterMed.isEmpty {
            cell.medNameLbl.text = filterMed[indexPath.row].term
        } else {
            cell.medNameLbl.text = medArray[indexPath.row].term
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !filterMed.isEmpty {
            txtFieldMedicineName.text = filterMed[indexPath.row].term
            nextBtn.isHidden = false
        } else {
            txtFieldMedicineName.text = medArray[indexPath.row].term
            nextBtn.isHidden = false
        }
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
