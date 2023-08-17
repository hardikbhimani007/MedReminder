//
//  MonthlySchedulViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class MonthlySchedulViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMonthlySchedulProtocol?
    
}

extension MonthlySchedulViewController: PresenterToViewMonthlySchedulProtocol{
    // TODO: Implement View Output Methods
}
