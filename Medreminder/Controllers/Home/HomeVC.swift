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
    //MARK: - Properties
    var arrMedDetalis = [MedicineDetalis]()
    let realm = try! Realm()
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
        navigationController?.navigationBar.isHidden = true
        setUp()
        setContextMenuForm()
        NotificationCenter.default.addObserver(self, selector: #selector(langungeChange), name: NSNotification.Name("LangugeChange"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDataBase()
        let tittle = NSMutableAttributedString(string: "\(localized(key: "BOOK APPOINTMENT"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 7.2, weight: .bold)])
        bookAppointmentBtn.setAttributedTitle(tittle, for: .normal)
        tableViewMedicine.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAlertHaslunchedBefore()
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
        self.datePickerView.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        let scopeGesture = UIPanGestureRecognizer(target: self.datePickerView, action: #selector(self.datePickerView.handleScopeGesture(_:)))
        self.datePickerView.addGestureRecognizer(scopeGesture)
        self.datePickerView.accessibilityIdentifier = "calendar"
    }
    
    @objc func tappedCancelBtn() {
        calenderView.isHidden = true
    }
    
    @objc func tappedvolumeBtn() {
        let stroyBoard = UIStoryboard(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "SoundVC") as! SoundVC
        self.navigationController?.pushViewController(stroyBoard, animated: true)
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
    //MARK: - Functions
    func setAlertHaslunchedBefore() {
        let alert = UIAlertController(title: "\(localized(key: "Set Name"))", message: "\(localized(key: "Enter your name"))", preferredStyle: .alert)
        alert.addTextField { (txtField) in
            txtField.placeholder = "\(localized(key: "Enter your name"))"
        }
        alert.addAction(UIAlertAction(title: "\(localized(key: "Ok"))", style: .default, handler: { [weak alert] (_) in
            let txtFiled = alert?.textFields?.first
            if let headerView = self.tableViewMedicine.headerView(forSection: 0) as? HeaderView {
                headerView.userNameLbl.text = txtFiled?.text
                headerView.userBtn.setTitle(txtFiled?.text, for: .normal)
                UserDefaults.standard.set(txtFiled?.text, forKey: "name")
            }
            print("TxtField:- \(txtFiled?.text ?? "")")
        }))
        
        let lunchedBefore = UserDefaults.standard.bool(forKey: "HaslunchBefore")
        if lunchedBefore {
            txtFieldName = UserDefaults.standard.string(forKey: "name") ?? ""
        } else {
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "HaslunchBefore")
        }
    }
    
    private func setUp() {
        bookAppointmentBtn.layer.cornerRadius = 10
        datePickerView.delegate = self
        datePickerView.dataSource = self
        registerNib()
        BtnActions()
    }
    
    func getDataFromDataBase() {
        let getData = Array(realm.objects(MedicineDetalis.self))
        arrMedDetalis = getData
        print(arrMedDetalis)
        tableViewMedicine.reloadData()
    }

     private func registerNib() {
         tableViewMedicine.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
         tableViewMedicine.register(UINib(nibName: "MedicineDetalisTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineDetalisTableViewCell")
         tableViewMedicine.separatorStyle = .none
         tableViewMedicine.reloadData()
    }
    
    func setContextMenuForm() {
        let AddMedication = UIAction(title: "\(localized(key: "Add medication"))") { action in
            print("Medication")
            let storyBoard = UIStoryboard(name: "AddMedication", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddMedicationVC") as! AddMedicationVC
            self.navigationController?.pushViewController(vc, animated: true)
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
        let cell: MedicineDetalisTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MedicineDetalisTableViewCell") as! MedicineDetalisTableViewCell
        cell.MedicineNameLbl.text = arrMedDetalis[indexPath.row].medicineName
        cell.MedTypeLbl.text = "1 \(arrMedDetalis[indexPath.row].medicineType ?? "")"
        cell.takingLbl.text = arrMedDetalis[indexPath.row].firstDose
        let ampm = arrMedDetalis[indexPath.row].hr ?? 0 >= 12 ? "PM" : "AM"
        let formatedTime = String(format: "%02d:%02d %@", arrMedDetalis[indexPath.row].hr!, arrMedDetalis[indexPath.row].min!, ampm)
        cell.timerLbl.text = formatedTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TakeMedicineVC") as! TakeMedicineVC
        let detalis = arrMedDetalis[indexPath.row]
        vc.medName = detalis.medicineName ?? ""
        vc.medType = detalis.medicineType ?? ""
        vc.firstDose = detalis.firstDose ?? ""
        vc.hr = detalis.hr ?? 0
        vc.min = detalis.min ?? 0
        vc.sec = detalis.sec ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        let hour = Calendar.current.component(.hour, from: Date())
        header.userNameLbl.text = UserDefaults.standard.string(forKey: "name")
        header.userBtn.setTitle(UserDefaults.standard.string(forKey: "name"), for: .normal)
        switch hour {
        case 6..<12 :
            header.goodMoringLbl.text = "\(localized(key: "Good Morning"))"
            
        case 12..<17 :
            header.goodMoringLbl.text = "\(localized(key: "Good Afternoon"))"
            
        case 17..<22 :
            header.goodMoringLbl.text = "\(localized(key: "Good Evening"))"
            
        default:
            header.goodMoringLbl.text = "\(localized(key: "Good Night"))"
        }
        
        header.userBtn.layer.cornerRadius = 10
        header.userBtn.contentHorizontalAlignment = .left
        return header
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
