//
//  SideMenuContract.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSideMenuProtocol {
    func showData(arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSideMenuProtocol {
    
    var view: PresenterToViewSideMenuProtocol? { get set }
    var interactor: PresenterToInteractorSideMenuProtocol? { get set }
    var router: PresenterToRouterSideMenuProtocol? { get set }
    func showRegisterNib(tableView: UITableView)
    func loadedDataShow()
    func showVC(navigationController: UINavigationController)
    func cellForRowAt(tableView: UITableView, arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu], arrImage: [String], indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSideMenuProtocol {
    
    var presenter: InteractorToPresenterSideMenuProtocol? { get set }
    func registerNib(tableView: UITableView)
    func loadData()
    func cellFor(tableView: UITableView, arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu], arrImage: [String], indexPath: IndexPath) -> UITableViewCell
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSideMenuProtocol {
    func showDataSucessfully(arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSideMenuProtocol {
    func pushToVC(navigationController: UINavigationController)
}
