//
//  TakeMedicineContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewTakeMedicineProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTakeMedicineProtocol {
    
    var view: PresenterToViewTakeMedicineProtocol? { get set }
    var interactor: PresenterToInteractorTakeMedicineProtocol? { get set }
    var router: PresenterToRouterTakeMedicineProtocol? { get set }
    func showToVC(index: Int?, navigationController: UINavigationController)
    func localNotification(med1: String, medName: String, medType: String, firstDose: String, medNameLbl: UILabel, medTypeLbl: UILabel, schedulLbl: UILabel, timeLbl: UILabel, hr: Int, min: Int)
    func deleteDataFromDatabase(index: Int)
    func showRootView()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTakeMedicineProtocol {
    
    var presenter: InteractorToPresenterTakeMedicineProtocol? { get set }
    func setUpLocalNotification(med1: String, medName: String, medType: String, firstDose: String, medNameLbl: UILabel, medTypeLbl: UILabel, schedulLbl: UILabel, timeLbl: UILabel, hr: Int, min: Int)
    func deleteData(index: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTakeMedicineProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTakeMedicineProtocol {
    func pushToVC(index: Int?, navigationController: UINavigationController)
    func setRootView()
}
