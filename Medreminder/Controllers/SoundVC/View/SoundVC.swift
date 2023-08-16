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
    // MARK: - Properties
    var presenter: ViewToPresenterSoundProtocol?
    var isSwitched = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundRouter.createModule(vc: self)
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showTittleLblAndBtn(tittleLbl: titleLbl, offLbl: offLbl, onLbl: onLbl, changeBtn: changeBtn, volumeView: volumeView)
    }
    //MARK: - Functions
    func setUp() {
        presenter?.showViewsAndLbl(volumeView: volumeView, soundView: soundView, onOffLbl: onOffLbl, languageLbl: languageLbl, changeBtn: changeBtn)
        volumeBtn.addTarget(self, action: #selector(tappedVolumeBtn), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
        presenter?.showDropShadow(soundView: soundView)
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
        presenter?.setAlert(presenter: presenter!, languageLbl: languageLbl, navigationController: navigationController!)
    }
}

extension SoundVC: PresenterToViewSoundProtocol{
    // TODO: Implement View Output Methods
}
