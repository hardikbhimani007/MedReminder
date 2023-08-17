//
//  ProfileInteractor.swift
//  Medreminder
//
//  Created by MacOS on 17/08/2023.
//  
//

import Foundation
import UIKit

class ProfileInteractor: PresenterToInteractorProfileProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterProfileProtocol?
    
    func changeLanguage(pageNotFound: UILabel, notesLbl: UILabel) {
        pageNotFound.text = "\(localized(key: "Page Not Found"))"
        notesLbl.text = "\(localized(key: "Please return to the homepage."))"
    }
}
