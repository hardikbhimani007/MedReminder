//
//  MedicineTypeViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class MedicineTypeViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMedicineTypeProtocol?
    
}

extension MedicineTypeViewController: PresenterToViewMedicineTypeProtocol{
    // TODO: Implement View Output Methods
}
