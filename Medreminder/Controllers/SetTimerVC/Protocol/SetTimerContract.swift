//
//  SetTimerContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSetTimerProtocol {
    func showTime(objMedicine: MedDetalis?)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSetTimerProtocol {
    
    var view: PresenterToViewSetTimerProtocol? { get set }
    var interactor: PresenterToInteractorSetTimerProtocol? { get set }
    var router: PresenterToRouterSetTimerProtocol? { get set }
    func showBtn(nextBtn: UIButton, updateBtn: UIButton)
    func showLblsAndBtn(hrLbl: UILabel, minLbl: UILabel, secLbl: UILabel, setTimeLbl: UILabel, nextBtn: UIButton)
    func showLocalNotification(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?)
    func addDataFrom(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?)
    func showToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func updateData(objMedicine: MedDetalis?, hour: Int, minute: Int, second: Int, navigationController: UINavigationController)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSetTimerProtocol {
    
    var presenter: InteractorToPresenterSetTimerProtocol? { get set }
    func setBtn(nextBtn: UIButton, updateBtn: UIButton)
    func setUpLblsAndBtn(hrLbl: UILabel, minLbl: UILabel, secLbl: UILabel, setTimeLbl: UILabel, nextBtn: UIButton)
    func setLocalNotification(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?)
    func addDataFromDatabase(hour: Int, minute: Int, second: Int, objMedicine: MedDetalis?)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSetTimerProtocol {
    func showTimeSuccessfully(objMedicine: MedDetalis?)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSetTimerProtocol {
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func updateDataWithVC(objMedicine: MedDetalis?, hour: Int, minute: Int, second: Int, navigationController: UINavigationController)
}
