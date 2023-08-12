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
    //MARK: - Properties
    var arrMedDetalis = [MedicineDetalis]()
    let realm = try! Realm()
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
        navigationController?.navigationBar.isHidden = true
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDataBase()
        let tittle = NSMutableAttributedString(string: "\(localized(key: "BOOK APPOINTMENT"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 7.2, weight: .bold)])
        bookAppointmetBtn.setAttributedTitle(tittle, for: .normal)
    }
    //MARK: - Functions
    func setUp() {
        fsDateView.layer.cornerRadius = 4
        bookAppointmetBtn.layer.cornerRadius = 10
        fsDateView.delegate = self
        fsDateView.dataSource = self
        registerNib()
        BtnActions()
    }
    
    func getDataFromDataBase() {
        let getData = Array(realm.objects(MedicineDetalis.self))
        arrMedDetalis = getData
        tableViewMedication.reloadData()
    }
    
    private func registerNib() {
        tableViewMedication.register(UINib(nibName: "MedicineDetalisTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineDetalisTableViewCell")
        tableViewMedication.separatorStyle = .none
    }
    
    func setContextMenuForm() {
        let AddMedication = UIAction(title: "\(localized(key: "Add medication"))") { action in
            print("Medication")
        }
        let AddDose = UIAction(title: "\(localized(key: "Add Dose"))") { action in
            print("Dose")
        }
        let AddNotes = UIAction(title: "\(localized(key: "Add Notes"))") { action in
            print("Notes")
        }
        addBtn.showsMenuAsPrimaryAction = true
        addBtn.menu = UIMenu(title: "", children: [AddNotes, AddDose, AddMedication])
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
        self.fsDateView.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        let scopeGesture = UIPanGestureRecognizer(target: self.fsDateView, action: #selector(self.fsDateView.handleScopeGesture(_:)))
        self.fsDateView.addGestureRecognizer(scopeGesture)
        self.fsDateView.accessibilityIdentifier = "calendar"
    }
    
    @objc func tappedCancelBtn() {
        calenderView.isHidden = true
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
extension MedicationVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedDetalis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MedicineDetalisTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineDetalisTableViewCell") as! MedicineDetalisTableViewCell
        cell.MedicineNameLbl.text = arrMedDetalis[indexPath.row].medicineName
        cell.MedTypeLbl.text = "1 \(arrMedDetalis[indexPath.row].medicineType ?? "")"
        cell.takingLbl.text = arrMedDetalis[indexPath.row].firstDose
        let ampm = arrMedDetalis[indexPath.row].hr ?? 0 >= 12 ? "PM" : "AM"
        let formatedTime = String(format: "%02d:%02d %@", arrMedDetalis[indexPath.row].hr!, arrMedDetalis[indexPath.row].min!, ampm)
        cell.timerLbl.text = formatedTime
        return cell
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
