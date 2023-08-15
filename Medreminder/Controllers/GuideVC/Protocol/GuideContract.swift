//
//  GuideContract.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import AVFoundation
import AVKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewGuideProtocol {
    func showData(arrGuide: [Guide])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterGuideProtocol {
    
    var view: PresenterToViewGuideProtocol? { get set }
    var interactor: PresenterToInteractorGuideProtocol? { get set }
    var router: PresenterToRouterGuideProtocol? { get set }
    func showRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func showPuchVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func fetchData()
    func showVideo(videoURL: String, navigationController: UINavigationController)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorGuideProtocol {
    
    var presenter: InteractorToPresenterGuideProtocol? { get set }
    func registerNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String)
    func loadData()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterGuideProtocol {
    func showDataSuccessfully(arrguide: [Guide])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterGuideProtocol {
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController)
    func loadVideo(videoURL: String, navigationController: UINavigationController)
}
