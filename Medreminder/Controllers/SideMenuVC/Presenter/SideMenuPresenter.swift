//
//  SideMenuPresenter.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SideMenuPresenter: ViewToPresenterSideMenuProtocol {

    // MARK: Properties
    var view: PresenterToViewSideMenuProtocol?
    var interactor: PresenterToInteractorSideMenuProtocol?
    var router: PresenterToRouterSideMenuProtocol?
    
    func showRegisterNib(tableView: UITableView) {
        interactor?.registerNib(tableView: tableView)
    }
    
    func loadedDataShow() {
        interactor?.loadData()
    }
    
    func showVC(navigationController: UINavigationController) {
        router?.pushToVC(navigationController: navigationController)
    }
    
    func cellForRowAt(tableView: UITableView, arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu], arrImage: [String], indexPath: IndexPath) -> UITableViewCell {
        interactor?.cellFor(tableView: tableView, arrMenu1: arrMenu1, arrMenu2: arrMenu2, arrMenu3: arrMenu3, arrMenu4: arrMenu4, arrImage: arrImage, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension SideMenuPresenter: InteractorToPresenterSideMenuProtocol {
    func showDataSucessfully(arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu]) {
        view?.showData(arrMenu1: arrMenu1, arrMenu2: arrMenu2, arrMenu3: arrMenu3, arrMenu4: arrMenu4)
    }
}
