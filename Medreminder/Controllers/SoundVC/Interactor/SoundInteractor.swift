//
//  SoundInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SoundInteractor: PresenterToInteractorSoundProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterSoundProtocol?
    
    func setUpViewsAndLbl(volumeView: UIView, soundView: UIView, onOffLbl: UILabel, languageLbl: UILabel, changeBtn: UIButton) {
        volumeView.layer.cornerRadius = 10
        soundView.layer.cornerRadius = 32
        onOffLbl.layer.cornerRadius = 30
        onOffLbl.layer.masksToBounds = true
        languageLbl.layer.cornerRadius = 16
        languageLbl.layer.masksToBounds = true
        changeBtn.layer.cornerRadius = 13.5
    }
    
    func setDropShadow(soundView: UIView) {
        soundView.layer.shouldRasterize = true
        soundView.layer.shadowColor = UIColor.black.cgColor
        soundView.layer.shadowOpacity = 0.2
        soundView.layer.shadowOffset = CGSize(width: -2, height: -3)
        soundView.layer.shadowRadius = 0.1
        soundView.layoutIfNeeded()
    }
    
    func setTittleLblAndBtn(tittleLbl: UILabel, offLbl: UILabel, onLbl: UILabel, changeBtn: UIButton, volumeView: UIView) {
        tittleLbl.text = "\(localized(key: "AUDIO"))"
        offLbl.text = "\(localized(key: "OFF"))"
        onLbl.text = "\(localized(key: "ON"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "CHANGE"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .medium)])
        changeBtn.setAttributedTitle(tittle, for: .normal)
        volumeView.layoutIfNeeded()
    }
    
    func setLanguage(lang: String) {
        let defaults = UserDefaults.standard
        defaults.set(lang, forKey: "AppleLanguage")
        defaults.synchronize()
        Bundle.setLanguage(lang)
    }
}
