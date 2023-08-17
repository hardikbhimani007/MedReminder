//
//  SoundViewController.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import UIKit

class SoundViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterSoundProtocol?
    
}

extension SoundViewController: PresenterToViewSoundProtocol{
    // TODO: Implement View Output Methods
}
