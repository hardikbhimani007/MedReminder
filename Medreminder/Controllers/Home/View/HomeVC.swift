//
//  HomeVC.swift
//  Medreminder
//
//  Created by MacOS on 27/07/2023.
//

import UIKit
import RealmSwift
import FSCalendar
import SwiftUI

class HomeVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var documnetBtn: UIButton!
    @IBOutlet weak var bookAppointmentBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var tableViewMedicine: UITableView!
    @IBOutlet weak var celenderBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var datePickerView: FSCalendar!
    
    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    var arrMedDetalis = [MedicineDetalis]()
    var txtFieldName = ""
    fileprivate var theme: Int = 0 {
        didSet {
            switch (theme) {
            case 0:
                self.datePickerView.appearance.weekdayTextColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.datePickerView.appearance.headerTitleColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.datePickerView.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.datePickerView.appearance.selectionColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.datePickerView.appearance.headerDateFormat = "MMMM yyyy"
                self.datePickerView.appearance.todayColor = UIColor(red: 198/255.0, green: 51/255.0, blue: 42/255.0, alpha: 1.0)
                self.datePickerView.appearance.borderRadius = 1.0
                self.datePickerView.appearance.headerMinimumDissolvedAlpha = 0.2
            case 1:
                self.datePickerView.appearance.weekdayTextColor = UIColor.red
                self.datePickerView.appearance.headerTitleColor = UIColor.darkGray
                self.datePickerView.appearance.eventDefaultColor = UIColor.green
                self.datePickerView.appearance.selectionColor = UIColor.blue
                self.datePickerView.appearance.headerDateFormat = "yyyy-MM";
                self.datePickerView.appearance.todayColor = UIColor.red
                self.datePickerView.appearance.borderRadius = 1.0
                self.datePickerView.appearance.headerMinimumDissolvedAlpha = 0.0
            case 2:
                self.datePickerView.appearance.weekdayTextColor = UIColor.red
                self.datePickerView.appearance.headerTitleColor = UIColor.red
                self.datePickerView.appearance.eventDefaultColor = UIColor.green
                self.datePickerView.appearance.selectionColor = UIColor.blue
                self.datePickerView.appearance.headerDateFormat = "yyyy/MM"
                self.datePickerView.appearance.todayColor = UIColor.orange
                self.datePickerView.appearance.borderRadius = 0
                self.datePickerView.appearance.headerMinimumDissolvedAlpha = 1.0
            default:
                break;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeRouter.createModule(vc: self)
        navigationController?.navigationBar.isHidden = true
        setUp()
        setContextMenuForm()
        NotificationCenter.default.addObserver(self, selector: #selector(langungeChange), name: NSNotification.Name("LangugeChange"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDataBase()
        presenter?.showChangesTittle(name: "\(localized(key: "BOOK APPOINTMENT"))", btn: bookAppointmentBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewMedicine.reloadData()
        setAlertHaslunchedBefore()
    }
    
    //MARK: - Functions
    func setAlertHaslunchedBefore() {
        presenter?.setAlertHasLunchedBefore(names: txtFieldName, tableView: tableViewMedicine, vc: self)
    }
    
    private func setUp() {
        presenter?.setUp(datePicker: datePickerView, button: bookAppointmentBtn)
        datePickerView.delegate = self
        datePickerView.dataSource = self
        presenter?.registerNibShow(tableView: tableViewMedicine, nibName: "HeaderView", nibName2: "MedicineDetalisTableViewCell", forHeaderFooterViewReuseIdentifier: "HeaderView", forCellReuseIdentifier: "MedicineDetalisTableViewCell")
        BtnActions()
    }
    
    func getDataFromDataBase() {
        presenter?.showDataFromView(tableView: tableViewMedicine)
    }
    
    func setContextMenuForm() {
        presenter?.showContextMenu(tittle1: "\(localized(key: "Add medication"))", tittle2: "\(localized(key: "Add Dose"))", tittle3: "\(localized(key: "Add Notes"))", addBtn: addBtn, navigationController: navigationController!)
    }
    //MARK: - Button Actions
    func BtnActions() {
        addBtn.addTarget(self, action: #selector(tappedAppBtn), for: .touchUpInside)
        celenderBtn.addTarget(self, action: #selector(tappedCelenderBtn), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedvolumeBtn), for: .touchUpInside)
        documnetBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    @objc func langungeChange() {
        setContextMenuForm()
    }
    
    @objc func tappedAppBtn() {
        setContextMenuForm()
    }
    
    @objc func tappedCelenderBtn() {
        calenderView.isHidden = false
        presenter?.tapGesture(datePickerView: datePickerView)
    }
    
    @objc func tappedCancelBtn() {
        calenderView.isHidden = true
    }
    
    @objc func tappedvolumeBtn() {
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
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedDetalis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.loadDataForCell(tableView: tableView, arrMedDtalis: arrMedDetalis, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showTakeMedicineVC(arrMedDetalis: arrMedDetalis, indexPath: indexPath, navigationController: navigationController!)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        presenter?.showHeaderView(tableView: tableView) ?? UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
//MARK: - FSCalendarDelegate & FSCalendarDataSource
extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.setCurrentPage(date, animated: true)
        calendar.select(date)
    }
     
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        var dateComponents:DateComponents = DateComponents()
        dateComponents.day = 28
        let currentCalander:Calendar = Calendar.current
        return currentCalander.date(byAdding:dateComponents, to: Date())!
    }
}

extension HomeVC: PresenterToViewHomeProtocol{
    // TODO: Implement View Output Methods
    func showData(arrMedDetalis: [MedicineDetalis]) {
        self.arrMedDetalis = arrMedDetalis
        self.tableViewMedicine.reloadData()
    }
}
