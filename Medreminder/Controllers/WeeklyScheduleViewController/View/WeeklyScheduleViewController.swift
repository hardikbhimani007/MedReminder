//
//  WeeklyScheduleViewController.swift
//  Medreminder
//
//  Created by MacOS on 31/07/2023.
//

import UIKit

class WeeklyScheduleViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var medicineTitleLbl: UILabel!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var tableViewDaySchedule: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    // MARK: - Properties
    var presenter: ViewToPresenterWeeklyScheduleProtocol?
    var medicinePurpose = Medicine()
    var arrDaySchedule = [MedicineSchedul]()
    var arrSchedule = [MedicineSchedul]()
    var selectedIndex: [Int] = []
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeeklyScheduleRouter.createModule(vc: self)
        getData()
        presenter?.showRegisterNib(tableView: tableViewDaySchedule, nibName: "MedicineTypeTableViewCell", forCellReuseIdentifier: "MedicineTypeTableViewCell")
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showLoadedData()
        presenter?.lblAndBtn(questionLbl: questionLbl, nextBtn: nextBtn, tableview: tableViewDaySchedule)
    }
    //MARK: - Functions
    func getData() {
        medicineTitleLbl.text = medicinePurpose.medicineName
    }
    
    //MARK: - Button Actions
    @objc func tappedNextBtn() {
        presenter?.showToVCWithData(medicineTittle: medicineTitleLbl, navigationController: navigationController!)
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
extension WeeklyScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDaySchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.cellForRowAt(tableView: tableView, arrDaySchedule: arrDaySchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch index {
        case 0: handleSection(withMaxCount: 7, indexPath: indexPath)
        case 1: handleSection(withMaxCount: 1, indexPath: indexPath)
        case 2: handleSection(withMaxCount: 2, indexPath: indexPath)
        case 3: handleSection(withMaxCount: 3, indexPath: indexPath)
        case 4: handleSection(withMaxCount: 4, indexPath: indexPath)
        case 5: handleSection(withMaxCount: 5, indexPath: indexPath)
        case 6: handleSection(withMaxCount: 6, indexPath: indexPath)
        case 7: handleSection(withMaxCount: 1, indexPath: indexPath)
        case 8: handleSection(withMaxCount: 3, indexPath: indexPath)
        default:
            break
        }
        tableView.reloadData()
    }
    
    func handleSection(withMaxCount maxCount: Int, indexPath: IndexPath) {
        if selectedIndex.count < maxCount {
            selectedIndex.append(indexPath.row)
            nextBtn.isHidden = false
        }  else {
            if selectedIndex.first != nil {
                selectedIndex.removeAll()
            }
            selectedIndex.append(indexPath.row)
        }
        nextBtn.isHidden = selectedIndex.count < maxCount
    }
}

extension WeeklyScheduleViewController: PresenterToViewWeeklyScheduleProtocol{
    // TODO: Implement View Output Methods
    func showData(arrDaySchedule: [MedicineSchedul]) {
        self.arrDaySchedule = arrDaySchedule
        self.tableViewDaySchedule.reloadData()
    }
}
