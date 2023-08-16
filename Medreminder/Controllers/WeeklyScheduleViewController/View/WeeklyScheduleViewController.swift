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
    var selectedIndex = 0
    
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
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}

extension WeeklyScheduleViewController: PresenterToViewWeeklyScheduleProtocol{
    // TODO: Implement View Output Methods
    func showData(arrDaySchedule: [MedicineSchedul]) {
        self.arrDaySchedule = arrDaySchedule
        self.tableViewDaySchedule.reloadData()
    }
}
