//
//  SoundPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SoundPresenter: ViewToPresenterSoundProtocol {

    // MARK: Properties
    var view: PresenterToViewSoundProtocol?
    var interactor: PresenterToInteractorSoundProtocol?
    var router: PresenterToRouterSoundProtocol?
    
    func showViewsAndLbl(volumeView: UIView, soundView: UIView, onOffLbl: UILabel, languageLbl: UILabel, changeBtn: UIButton) {
        interactor?.setUpViewsAndLbl(volumeView: volumeView, soundView: soundView, onOffLbl: onOffLbl, languageLbl: languageLbl, changeBtn: changeBtn)
    }
    
    func showDropShadow(soundView: UIView) {
        interactor?.setDropShadow(soundView: soundView)
    }
    
    func showTittleLblAndBtn(tittleLbl: UILabel, offLbl: UILabel, onLbl: UILabel, changeBtn: UIButton, volumeView: UIView) {
        interactor?.setTittleLblAndBtn(tittleLbl: tittleLbl, offLbl: offLbl, onLbl: onLbl, changeBtn: changeBtn, volumeView: volumeView)
    }
    
    func changLanguage(lang: String) {
        interactor?.setLanguage(lang: lang)
    }
    
    func setAlert(presenter: ViewToPresenterSoundProtocol, languageLbl: UILabel, navigationController: UINavigationController) {
        router?.showAlert(presenter: presenter, languageLbl: languageLbl, navigationController: navigationController)
    }
}

extension SoundPresenter: InteractorToPresenterSoundProtocol {
    
}
