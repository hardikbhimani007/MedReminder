//
//  AddMedicationViewController.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import UIKit

class AddMedicationViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterAddMedicationProtocol?
    
}

extension AddMedicationViewController: PresenterToViewAddMedicationProtocol{
    // TODO: Implement View Output Methods
}
