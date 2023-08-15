//
//  MedicationVC.swift
//  Medreminder
//
//  Created by MacOS on 28/07/2023.
//

import UIKit
import RealmSwift
import FSCalendar

class MedicationVC: UIViewController {
//MARK: - IBOutlet
    @IBOutlet weak var medicationView: UIView!
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var bookAppointmetBtn: UIButton!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var tableViewMedication: UITableView!
    @IBOutlet weak var calenderbtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var fsDateView: FSCalendar!
    @IBOutlet weak var cancelBtn: UIButton!
    
    // MARK: - Properties
    var presenter: ViewToPresenterMedicationProtocol?
    var arrMedDetalis = [MedicineDetalis]()
    fileprivate var theme: Int = 0 {
        didSet {
            switch (theme) {
            case 0:
                self.fsDateView.appearance.weekdayTextColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.fsDateView.appearance.headerTitleColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.fsDateView.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.fsDateView.appearance.selectionColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.fsDateView.appearance.headerDateFormat = "MMMM yyyy"
                self.fsDateView.appearance.todayColor = UIColor(red: 198/255.0, green: 51/255.0, blue: 42/255.0, alpha: 1.0)
                self.fsDateView.appearance.borderRadius = 1.0
                self.fsDateView.appearance.headerMinimumDissolvedAlpha = 0.2
            case 1:
                self.fsDateView.appearance.weekdayTextColor = UIColor.red
                self.fsDateView.appearance.headerTitleColor = UIColor.darkGray
                self.fsDateView.appearance.eventDefaultColor = UIColor.green
                self.fsDateView.appearance.selectionColor = UIColor.blue
                self.fsDateView.appearance.headerDateFormat = "yyyy-MM";
                self.fsDateView.appearance.todayColor = UIColor.red
                self.fsDateView.appearance.borderRadius = 1.0
                self.fsDateView.appearance.headerMinimumDissolvedAlpha = 0.0
            case 2:
                self.fsDateView.appearance.weekdayTextColor = UIColor.red
                self.fsDateView.appearance.headerTitleColor = UIColor.red
                self.fsDateView.appearance.eventDefaultColor = UIColor.green
                self.fsDateView.appearance.selectionColor = UIColor.blue
                self.fsDateView.appearance.headerDateFormat = "yyyy/MM"
                self.fsDateView.appearance.todayColor = UIColor.orange
                self.fsDateView.appearance.borderRadius = 0
                self.fsDateView.appearance.headerMinimumDissolvedAlpha = 1.0
            default:
                break;
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        MedicationRouter.createModule(vc: self)
        navigationController?.navigationBar.isHidden = true
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDataBase()
        presenter?.showChangesTittle(name: "\(localized(key: "BOOK APPOINTMENT"))", btn: bookAppointmetBtn)
    }
    //MARK: - Functions
    func setUp() {
        presenter?.setUp(datePicker: fsDateView, button: bookAppointmetBtn)
        fsDateView.delegate = self
        fsDateView.dataSource = self
        presenter?.registerNibShow(tableView: tableViewMedication, nibName: "MedicineDetalisTableViewCell", forCellReuseIdentifier: "MedicineDetalisTableViewCell")
        BtnActions()
    }
    
    func getDataFromDataBase() {
        presenter?.showDataFromView(tableView: tableViewMedication)
    }
    
    func setContextMenuForm() {
        presenter?.showContextMenu(tittle1: "\(localized(key: "Add medication"))", tittle2: "\(localized(key: "Add Dose"))", tittle3: "\(localized(key: "Add Notes"))", addBtn: addBtn, navigationController: navigationController!)
    }
    //MARK: - Button Actions
    func BtnActions() {
        addBtn.addTarget(self, action: #selector(tappedAppBtn), for: .touchUpInside)
        calenderbtn.addTarget(self, action: #selector(tappedCelenderBtn), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    @objc func tappedAppBtn() {
        setContextMenuForm()
        tabBarController?.selectedIndex = 0
    }
    
    @objc func tappedCelenderBtn() {
        calenderView.isHidden = false
        presenter?.tapGesture(datePickerView: fsDateView)
    }
    
    @objc func tappedCancelBtn() {
        calenderView.isHidden = true
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
        navigationController?.view.layer.add(transition, forKey: nil)
        presenter?.showToVC(storyBoardName: "Home", withIdentifier: "SideMenuViewController", navigationController: navigationController!)
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension MedicationVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedDetalis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.loadDataForCell(tableView: tableView, arrMedDtalis: arrMedDetalis, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
//MARK: - FSCalendarDelegate & FSCalendarDataSource
extension MedicationVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calenderView.isHidden = true
        self.tabBarController?.selectedIndex = 2
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

extension MedicationVC: PresenterToViewMedicationProtocol{
    // TODO: Implement View Output Methods
    func showData(arrMedDetalis: [MedicineDetalis]) {
        self.arrMedDetalis = arrMedDetalis
        self.tableViewMedication.reloadData()
    }
}
