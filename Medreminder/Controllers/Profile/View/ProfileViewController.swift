//
//  ProfileViewController.swift
//  Medreminder
//
//  Created by MacOS on 17/08/2023.
//  
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var dataNotFoundImg: UIImageView!
    @IBOutlet weak var pageNotFoundLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    // MARK: - Properties
    var presenter: ViewToPresenterProfileProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileRouter.createModule(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.showChangeLanguage(pageNotFound: pageNotFoundLbl, notesLbl: notesLbl)
    }
    
}

extension ProfileViewController: PresenterToViewProfileProtocol{
    // TODO: Implement View Output Methods
}
