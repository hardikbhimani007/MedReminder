//
//  MonthlySchedulVC.swift
//  Medreminder
//
//  Created by MacOS on 31/07/2023.
//

import UIKit

class MonthlySchedulVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var documnetBtn: UIButton!
    @IBOutlet weak var medicineTitle: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableviewMonthlySchedul: UITableView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    // MARK: - Properties
    var presenter: ViewToPresenterMonthlySchedulProtocol?
    var medicinePurpose = Medicine()
    var arrSchedule = [MedicineSchedul]()
    var selectedIndex = 0
    var index: Int?
    var objMedicine: MedDetalis?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MonthlySchedulRouter.createModule(vc: self)
        getData()
        presenter?.setRegisterNib(tableView: tableviewMonthlySchedul, nibName: "MedicineTypeTableViewCell", forCellReuseIdentifier: "MedicineTypeTableViewCell")
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documnetBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadedData()
        presenter?.showTittleAndBtn(questionLbl: questionLbl, nextBtn: nextBtn, tableView: tableviewMonthlySchedul)
    }
    //MARK: - Functions
    func getData() {
        medicineTitle.text = medicinePurpose.medicineName
    }
    
    //MARK: - Buttons Actions
    @objc func tappedNextBtn() {
        presenter?.showToVC(index: index ?? 0, medName: objMedicine?.medName ?? "", medType: objMedicine?.medType ?? "", firstDose: objMedicine?.firstDose ?? "", hr: objMedicine?.hr ?? 0, min: objMedicine?.min ?? 0, sec: objMedicine?.sec ?? 0, isUpdate: objMedicine?.isEdit ?? false, indxed: objMedicine?.index ?? 0, arrSchedule: arrSchedule, medicineLabel: medicineTitle, navigationController: navigationController!)
    }
    
    @objc func tappedBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedVolumeBtn() {
        presenter?.setVC(storyBoardName: "Home", withIdentifier: "SoundVC", navigationController: navigationController!)
    }
    
    @objc func tappedDocumnetBtn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController!.view.layer.add(transition, forKey: nil)
        presenter?.setVC(storyBoardName: "Home", withIdentifier: "SideMenuViewController", navigationController: navigationController!)
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension MonthlySchedulVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.cellForRowAt(tableView: tableView, arrSchedule: arrSchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}

extension MonthlySchedulVC: PresenterToViewMonthlySchedulProtocol{
    // TODO: Implement View Output Methods
    func loadData(arrSchedule: [MedicineSchedul]) {
        self.arrSchedule = arrSchedule
        self.tableviewMonthlySchedul.reloadData()
    }
    
    func setIndex(index: Int?) {
        self.index = index
    }
}
