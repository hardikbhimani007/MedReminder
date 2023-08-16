//
//  FirstDosePresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class FirstDosePresenter: ViewToPresenterFirstDoseProtocol {

    // MARK: Properties
    var view: PresenterToViewFirstDoseProtocol?
    var interactor: PresenterToInteractorFirstDoseProtocol?
    var router: PresenterToRouterFirstDoseProtocol?
    
    func showRegisterNib(collectionView: UICollectionView, nibName: String, forCellWithReuseIdentifier: String) {
        interactor?.registerNib(collectionView: collectionView, nibName: nibName, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
    
    func loadedDataFetch() {
        interactor?.loadData()
    }
    
    func showTittleAndLbl(questionLbl: UILabel, nextBtn: UIButton, collectionView: UICollectionView) {
        interactor?.setTittleAndBtn(questionLbl: questionLbl, nextBtn: nextBtn, collectionView: collectionView)
    }
    
    func showDataToVC(selectedIndex: String, medicinetittle: UILabel, navigationController: UINavigationController) {
        router?.pushToVCWithData(selectedIndex: selectedIndex, medicinetittle: medicinetittle, navigationController: navigationController)
    }
    
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func cellForRowAt(collectionView: UICollectionView, arrDaySchedule: [MedicineSchedul], selectedIndex: Int, nextBtn: UIButton, indexPath: IndexPath) -> UICollectionViewCell {
        interactor?.cellForRow(collectionView: collectionView, arrDaySchedule: arrDaySchedule, selectedIndex: selectedIndex, nextBtn: nextBtn, indexPath: indexPath) ?? UICollectionViewCell()
    }
}

extension FirstDosePresenter: InteractorToPresenterFirstDoseProtocol {
    func showDataSucessfully(arrDaySchedule: [MedicineSchedul]) {
        view?.showData(arrDaySchedule: arrDaySchedule)
    }
    
    func showIndexSuccessfully(selectedIndexType: String) {
        view?.showIndex(selectedIndexType: selectedIndexType)
    }
}
