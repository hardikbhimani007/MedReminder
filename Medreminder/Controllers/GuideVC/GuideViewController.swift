//
//  GuideViewController.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import UIKit

class GuideViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterGuideProtocol?
    
}

extension GuideViewController: PresenterToViewGuideProtocol{
    // TODO: Implement View Output Methods
}
