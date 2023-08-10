//
//  SoundVC.swift
//  Medreminder
//
//  Created by MacOS on 01/08/2023.
//

import UIKit
import SwiftUI

class SoundVC: UIViewController {
    //MARK: - IBoutlet
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var volumeView: UIView!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var onOffLbl: UILabel!
    @IBOutlet weak var onOffLblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var offLbl: UILabel!
    @IBOutlet weak var onLbl: UILabel!
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    //MARK: - Properties
    var isSwitched = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLbl.text = "\(localized(key: "AUDIO"))"
        offLbl.text = "\(localized(key: "OFF"))"
        onLbl.text = "\(localized(key: "ON"))"
        let tittle = NSMutableAttributedString(string: "\(localized(key: "CHANGE"))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .medium)])
        changeBtn.setAttributedTitle(tittle, for: .normal)
        volumeView.layoutIfNeeded()
    }
    //MARK: - Functions
    func setUp() {
        volumeView.layer.cornerRadius = 10
        soundView.layer.cornerRadius = 32
        onOffLbl.layer.cornerRadius = 30
        onOffLbl.layer.masksToBounds = true
        languageLbl.layer.cornerRadius = 16
        languageLbl.layer.masksToBounds = true
        changeBtn.layer.cornerRadius = 13.5
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
        dropShadowFromSoundView()
    }
    
    func dropShadowFromSoundView() {
        soundView.layer.shouldRasterize = true
        soundView.layer.shadowColor = UIColor.black.cgColor
        soundView.layer.shadowOpacity = 0.2
        soundView.layer.shadowOffset = CGSize(width: -2, height: -3)
        soundView.layer.shadowRadius = 0.1
        soundView.layoutIfNeeded()
    }
    
    private func changeLanguge(_ lang: String) {
        let defaults = UserDefaults.standard
        defaults.set(lang, forKey: "AppleLanguage")
        defaults.synchronize()
        Bundle.setLanguage(lang)
    }
    
    func changeLanguage() {
        let alertAction = UIAlertController(title: "\(localized(key: "Select languge"))", message: nil, preferredStyle: .actionSheet)
        let englishAction = UIAlertAction(title: "\(localized(key: "English"))", style: .default) { alert in
            self.changeLanguge("en")
            self.languageLbl.text = "\(localized(key: "English"))"
        }
        let hindiAction = UIAlertAction(title: "\(localized(key: "Hindi"))", style: .default) { alert in
            self.changeLanguge("hi")
            self.languageLbl.text = "\(localized(key: "Hindi"))"
        }
        let cancel = UIAlertAction(title: "\(localized(key: "Cancel"))", style: .cancel, handler: nil)
        alertAction.addAction(englishAction)
        alertAction.addAction(hindiAction)
        alertAction.addAction(cancel)
        present(alertAction, animated: true, completion: nil)
    }
    //MARK: - Button Actions
    @objc func tappedVolumeBtn() {
        if isSwitched {
            onOffLbl.text = "\(localized(key: "ON"))"
            onOffLblLeadingConstraint.constant = 122
        } else {
            onOffLbl.text = "\(localized(key: "OFF"))"
            onOffLblLeadingConstraint.constant = 6
        }
        isSwitched = !isSwitched
    }
    
    @objc func tappedCancelBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedChangeBtn(_ sender: UIButton) {
       changeLanguage()
    }
}
