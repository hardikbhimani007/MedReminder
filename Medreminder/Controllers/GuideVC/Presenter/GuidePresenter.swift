//
//  GuidePresenter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit

class GuidePresenter: ViewToPresenterGuideProtocol {

    // MARK: Properties
    var view: PresenterToViewGuideProtocol?
    var interactor: PresenterToInteractorGuideProtocol?
    var router: PresenterToRouterGuideProtocol?
    
    func showRegisterNib(tableView: UITableView, nibName: String, forCellReuseIdentifier: String) {
        interactor?.registerNib(tableView: tableView, nibName: nibName, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func showPuchVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        router?.pushToVC(storyBoardName: storyBoardName, withIdentifier: withIdentifier, navigationController: navigationController)
    }
    
    func fetchData() {
        interactor?.loadData()
    }
    
    func showVideo(videoURL: String, navigationController: UINavigationController) {
        router?.loadVideo(videoURL: videoURL, navigationController: navigationController)
    }
}

extension GuidePresenter: InteractorToPresenterGuideProtocol {
    func showDataSuccessfully(arrguide: [Guide]) {
        view?.showData(arrGuide: arrguide)
    }
}
