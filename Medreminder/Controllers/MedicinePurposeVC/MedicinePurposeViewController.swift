//
//  MedicinePurposeViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class MedicinePurposeViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMedicinePurposeProtocol?
    
}

extension MedicinePurposeViewController: PresenterToViewMedicinePurposeProtocol{
    // TODO: Implement View Output Methods
}
