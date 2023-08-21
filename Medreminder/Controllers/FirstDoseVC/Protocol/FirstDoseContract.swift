//
//  FirstDoseContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewFirstDoseProtocol {
    func showData(arrDaySchedule: [MedicineSchedul])
    func showIndex(selectedIndexType: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterFirstDoseProtocol {
    
    var view: PresenterToViewFirstDoseProtocol? { get set }
    var interactor: PresenterToInteractorFirstDoseProtocol? { get set }
    var router: PresenterToRouterFirstDoseProtocol? { get set }
    func showRegisterNib(collectionView: UICollectionView, nibName: String, forCellWithReuseIdentifier: String)
    func loadedDataFetch()
    func showTittleAndLbl(questionLbl: UILabel, nextBtn: UIButton, collectionView: UICollectionView)
    func showDataToVC(selectedIndex: String, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicinetittle: UILabel, navigationController: UINavigationController)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func cellForRowAt(collectionView: UICollectionView, arrDaySchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UICollectionViewCell
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorFirstDoseProtocol {
    
    var presenter: InteractorToPresenterFirstDoseProtocol? { get set }
    func registerNib(collectionView: UICollectionView, nibName: String, forCellWithReuseIdentifier: String)
    func loadData()
    func setTittleAndBtn(questionLbl: UILabel, nextBtn: UIButton, collectionView: UICollectionView)
    func cellForRow(collectionView: UICollectionView, arrDaySchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UICollectionViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterFirstDoseProtocol {
    func showDataSucessfully(arrDaySchedule: [MedicineSchedul])
    func showIndexSuccessfully(selectedIndexType: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterFirstDoseProtocol {
    func pushToVCWithData(selectedIndex: String, medName: String, medType: String, firstDose: String, hr: Int, min: Int, sec: Int, isUpdate: Bool, index: Int, medicinetittle: UILabel, navigationController: UINavigationController)
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
}
