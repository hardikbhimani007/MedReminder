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
    // MARK: - Properties
    var presenter: ViewToPresenterFirstDoseProtocol?
    var medicinePurpose = Medicine()
    var arrDaySchedule = [MedicineSchedul]()
    var selectedIndex = 0
    var objMed: MedDetalis?
    var selectedIndexType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstDoseRouter.createModule(vc: self)
        getData()
        presenter?.showRegisterNib(collectionView: collectionviewDose, nibName: "FirstDoseCollectionViewCell", forCellWithReuseIdentifier: "FirstDoseCollectionViewCell")
        nextBtn.layer.cornerRadius = 22.5
        nextBtn.addTarget(self, action: #selector(tappedNextBtn), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        VolumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadedDataFetch()
        presenter?.showTittleAndLbl(questionLbl: questionLbl, nextBtn: nextBtn, collectionView: collectionviewDose)
    }
    //MARK: - Functions
    func getData() {
        medicineTitleLbl.text = medicinePurpose.medicineName
    }
    
    //MARK: - Button Actions
    @objc func tappedNextBtn() {
        presenter?.showDataToVC(selectedIndex: selectedIndexType, medicinetittle: medicineTitleLbl, navigationController: navigationController!)
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
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension FirstDoseVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDaySchedule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter?.cellForRowAt(collectionView: collectionView, arrDaySchedule: arrDaySchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UICollectionViewCell()
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

extension FirstDoseVC: PresenterToViewFirstDoseProtocol{
    // TODO: Implement View Output Methods
    func showData(arrDaySchedule: [MedicineSchedul]) {
        self.arrDaySchedule = arrDaySchedule
        self.collectionviewDose.reloadData()
    }
    
    func showIndex(selectedIndexType: String) {
        self.selectedIndexType = selectedIndexType
    }
}
