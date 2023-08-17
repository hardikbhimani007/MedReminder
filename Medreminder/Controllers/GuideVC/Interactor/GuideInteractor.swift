//
//  GuideInteractor.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit

class GuideInteractor: PresenterToInteractorGuideProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterGuideProtocol?
    
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func loadData() {
        let data1 = Guide(name: "\(localized(key: "How to add new medicine?"))", videoURL: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let data2 = Guide(name: "\(localized(key: "How to add new medicine?"))", videoURL: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let data3 = Guide(name: "\(localized(key: "How to add new medicine?"))", videoURL: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        presenter?.showDataSuccessfully(arrguide: [data1, data2, data3])
    }
}
