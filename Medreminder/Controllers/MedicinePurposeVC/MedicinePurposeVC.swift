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
    //MARK: - Properties
    var medicinePurpose = Medicine()
    var arrMedPupose = [MedicineName]()
    var filterMed = [MedicineName]()
    var getStrength = ""
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicinePurposeSetUp()
        getData()
        registerNib()
        getMedData()
        txtFieldChooseReason.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionLbl.text = "\(localized(key: "What is the purpose for taking this medication?"))"
        noteLbl.text = "\(localized(key: "Type and choose the reason from the list"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
    }
    //MARK: - Functions
    func getData() {
        medicinePurposeTitle.text = medicinePurpose.medicineName
    }
    
    private func medicinePurposeSetUp() {
        txtFieldView.layer.cornerRadius = 22.5
        txtFieldChooseReason.borderStyle = .none
        txtFieldView.layer.borderColor = UIColor.cyan.cgColor
        txtFieldView.layer.borderWidth = 1
        nextBtn.layer.cornerRadius = 25
        txtFieldChooseReason.addTarget(self, action: #selector(textViewDidChange(_:)), for: UIControl.Event.editingChanged)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
     }
    
    func getMedData() {
        guard let url = URL(string: "https://api.fda.gov/drug/label.json?count=openfda.brand_name.exact&limit=500") else { return }
        AF.request(url).responseDecodable(of: MedicineResponse.self) { [self] response in
            guard let medResponse = response.value else { return }
            self.arrMedPupose = medResponse.results
            DispatchQueue.main.async {
                self.tableViewMedPurpose.reloadData()
            }
        }
    }
    
    func registerNib() {
        tableViewMedPurpose.register(UINib(nibName: "MedicineNameTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineNameTableViewCell")
        tableViewMedPurpose.separatorStyle = .none
    }
    //MARK: - Button Actions
    @objc  func textViewDidChange(_ textView: UITextView) {
        nextBtn.isHidden = true
        tableViewMedPurpose.isHidden = true
        if txtFieldChooseReason.text!.isEmpty {
            noteLbl.isHidden = false
            tableViewMedPurpose.isHidden = true
        } else {
            noteLbl.isHidden = true
            nextBtn.isHidden = false
            tableViewMedPurpose.isHidden = false
        }
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedNextBtn() {
        let storyBoard = UIStoryboard(name: "MedicinePurpose", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MonthlySchedulVC") as! MonthlySchedulVC
        let detalis = Medicine(medicineName: "\(medicinePurposeTitle.text!)")
        vc.medicinePurpose = detalis
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
extension MedicinePurposeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filterMed.isEmpty {
            return filterMed.count
        }
        return filtered ? 0 : arrMedPupose.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineNameTableViewCell") as! MedicineNameTableViewCell
        if !filterMed.isEmpty {
            cell.medNameLbl.text = filterMed[indexPath.row].term
        } else {
            cell.medNameLbl.text = arrMedPupose[indexPath.row].term
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !filterMed.isEmpty {
            txtFieldChooseReason.text = filterMed[indexPath.row].term
            nextBtn.isHidden = false
        } else {
            txtFieldChooseReason.text = arrMedPupose[indexPath.row].term
            nextBtn.isHidden = false
        }
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
