//
//  SoundRouter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SoundRouter: PresenterToRouterSoundProtocol {
    
    // MARK: Static methods
    static func createModule(vc: SoundVC){
        
        let presenter: ViewToPresenterSoundProtocol & InteractorToPresenterSoundProtocol = SoundPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = SoundRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = SoundInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func showAlert(presenter: ViewToPresenterSoundProtocol, languageLbl: UILabel, navigationController: UINavigationController) {
        let alertAction = UIAlertController(title: "\(localized(key: "Select languge"))", message: nil, preferredStyle: .actionSheet)
        let englishAction = UIAlertAction(title: "\(localized(key: "English"))", style: .default) { alert in
            presenter.changLanguage(lang: "en")
            languageLbl.text = "\(localized(key: "English"))"
        }
        let hindiAction = UIAlertAction(title: "\(localized(key: "Hindi"))", style: .default) { alert in
            presenter.changLanguage(lang: "hi")
            languageLbl.text = "\(localized(key: "Hindi"))"
        }
        let cancel = UIAlertAction(title: "\(localized(key: "Cancel"))", style: .cancel, handler: nil)
        alertAction.addAction(englishAction)
        alertAction.addAction(hindiAction)
        alertAction.addAction(cancel)
        navigationController.present(alertAction, animated: true, completion: nil)
    }
}
