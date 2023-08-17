//
//  SetTimerViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class SetTimerViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterSetTimerProtocol?
    
}

extension SetTimerViewController: PresenterToViewSetTimerProtocol{
    // TODO: Implement View Output Methods
}
