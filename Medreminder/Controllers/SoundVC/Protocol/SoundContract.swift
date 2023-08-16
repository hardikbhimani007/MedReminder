//
//  SoundContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSoundProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSoundProtocol {
    
    var view: PresenterToViewSoundProtocol? { get set }
    var interactor: PresenterToInteractorSoundProtocol? { get set }
    var router: PresenterToRouterSoundProtocol? { get set }
    func showViewsAndLbl(volumeView: UIView, soundView: UIView, onOffLbl: UILabel, languageLbl: UILabel, changeBtn: UIButton)
    func showDropShadow(soundView: UIView)
    func showTittleLblAndBtn(tittleLbl: UILabel, offLbl: UILabel, onLbl: UILabel, changeBtn: UIButton, volumeView: UIView)
    func changLanguage(lang: String)
    func setAlert(presenter: ViewToPresenterSoundProtocol, languageLbl: UILabel, navigationController: UINavigationController)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSoundProtocol {
    
    var presenter: InteractorToPresenterSoundProtocol? { get set }
    func setUpViewsAndLbl(volumeView: UIView, soundView: UIView, onOffLbl: UILabel, languageLbl: UILabel, changeBtn: UIButton)
    func setDropShadow(soundView: UIView)
    func setTittleLblAndBtn(tittleLbl: UILabel, offLbl: UILabel, onLbl: UILabel, changeBtn: UIButton, volumeView: UIView)
    func setLanguage(lang: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSoundProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSoundProtocol {
    func showAlert(presenter: ViewToPresenterSoundProtocol, languageLbl: UILabel, navigationController: UINavigationController)
}
