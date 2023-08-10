//
//  FirstDoseVC.swift
//  Medreminder
//
//  Created by MacOS on 31/07/2023.
//

import UIKit
import RealmSwift

class FirstDoseVC: UIViewController {
    //MARK: - IBoutlet
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var VolumeBtn: UIButton!
    @IBOutlet weak var medicineTitleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var collectionviewDose: UICollectionView!
    //MARK: - Properties
    var medicinePurpose = Medicine()
    var arrDaySchedule = [MedicineSchedul]()
    var selectedIndex = 0
    var objMed: MedDetalis?
    var selectedIndexType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        registerNib()
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        VolumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        questionLbl.text = "\(localized(key: "At what time do you need your first dose?"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "Next"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        nextBtn.setAttributedTitle(tittle, for: .normal)
        collectionviewDose.reloadData()
    }
    //MARK: - Functions
    func getData() {
        medicineTitleLbl.text = medicinePurpose.medicineName
    }

    func AddDataFromDatabase() {
        do {
            if let data = UserDefaults.standard.data(forKey: "ObjMedicine") {
                let objMed = try JSONDecoder().decode(MedDetalis.self, from: data)
                let realm = try! Realm()
                let detail = MedicineDetalis()
                detail.medicineName = objMed.medName
                detail.medicineType = objMed.medType
                detail.firstDose = selectedIndexType
                try! realm.write({
                    realm.add(detail)
                })
                print(objMed)
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
    }
    
    func registerNib() {
        collectionviewDose.register(UINib(nibName: "FirstDoseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstDoseCollectionViewCell")
    }
    
    func loadData() {
        let data1 = MedicineSchedul(time: "\(localized(key: "Morning"))")
        let data2 = MedicineSchedul(time: "\(localized(key: "Before Food"))")
        let data3 = MedicineSchedul(time: "\(localized(key: "Afternoon"))")
        let data4 = MedicineSchedul(time: "\(localized(key: "After Food"))")
        let data5 = MedicineSchedul(time: "\(localized(key: "Evening"))")
        let data6 = MedicineSchedul(time: "\(localized(key: "Anytime"))")
        let data7 = MedicineSchedul(time: "\(localized(key: "Night"))")
        arrDaySchedule = [data1, data2, data3, data4, data5, data6, data7]
    }
    //MARK: - Button Actions
    @objc func tappedNextBtn() {
        let storyBoard = UIStoryboard(name: "MedicinePurpose", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SetTimerVC") as! SetTimerVC
        let detalis = Medicine(medicineName: medicineTitleLbl.text!)
        do {
            if let data = UserDefaults.standard.data(forKey: "ObjMedicine") {
                var objMed = try JSONDecoder().decode(MedDetalis.self, from: data)
                objMed = MedDetalis(medName: objMed.medName, medType: objMed.medType, firstDose: selectedIndexType, hr: 0, min: 0, sec: 0)
                print(">>>>>>>>",objMed)
                vc.objMedicine = objMed
                vc.medicinePurpose = detalis
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
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
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension FirstDoseVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDaySchedule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FirstDoseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstDoseCollectionViewCell", for: indexPath) as! FirstDoseCollectionViewCell
        cell.doseLbl.text = arrDaySchedule[indexPath.row].time
        if selectedIndex == indexPath.row {
            cell.selectionBtn.isSelected = true
            nextBtn.isHidden = false
            selectedIndexType = cell.doseLbl.text!
        } else {
            cell.selectionBtn.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension FirstDoseVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

}
