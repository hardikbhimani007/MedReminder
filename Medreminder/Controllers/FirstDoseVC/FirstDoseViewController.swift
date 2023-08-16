//
//  FirstDoseViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class FirstDoseViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterFirstDoseProtocol?
    
}

extension FirstDoseViewController: PresenterToViewFirstDoseProtocol{
    // TODO: Implement View Output Methods
}
