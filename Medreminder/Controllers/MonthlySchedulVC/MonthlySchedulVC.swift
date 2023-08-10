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
    //MARK: - Properties
    var medicinePurpose = Medicine()
    var arrSchedule = [MedicineSchedul]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        registerNib()
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documnetBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        questionLbl.text = "\(localized(key: "How often do you take this medicine?"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        tableviewMonthlySchedul.reloadData()
    }
    //MARK: - Functions
    func getData() {
        medicineTitle.text = medicinePurpose.medicineName
    }
    
    func registerNib() {
        tableviewMonthlySchedul.register(UINib(nibName: "MedicineTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineTypeTableViewCell")
        tableviewMonthlySchedul.separatorStyle = .none
    }
    
    func loadData() {
        let data1 = MedicineSchedul(time: "\(localized(key: "Daliy"))")
        let data2 = MedicineSchedul(time: "\(localized(key: "Once a week"))")
        let data3 = MedicineSchedul(time: "\(localized(key: "2 days a week"))")
        let data4 = MedicineSchedul(time: "\(localized(key: "3 days a week"))")
        let data5 = MedicineSchedul(time: "\(localized(key: "4 days a week"))")
        let data6 = MedicineSchedul(time: "\(localized(key: "5 days a week"))")
        let data7 = MedicineSchedul(time: "\(localized(key: "6 days a week"))")
        let data8 = MedicineSchedul(time: "\(localized(key: "Once a month"))")
        let data9 = MedicineSchedul(time: "\(localized(key: "Alternate days"))")
        arrSchedule = [data1, data2, data3, data4, data5, data6, data7, data8, data9]
    }
    //MARK: - Buttons Actions
    @objc func tappedNextBtn() {
        let storyBoard = UIStoryboard(name: "MedicinePurpose", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyScheduleViewController") as! WeeklyScheduleViewController
        let detalis = Medicine(medicineName: medicineTitle.text!)
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
extension MonthlySchedulVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineTypeTableViewCell") as! MedicineTypeTableViewCell
        let type = arrSchedule[indexPath.row]
        cell.MedicineType.text = type.time
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            nextBtn.isHidden = false
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
