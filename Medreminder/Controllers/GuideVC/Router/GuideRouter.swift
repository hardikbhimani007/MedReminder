//
//  GuideRouter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class GuideRouter: PresenterToRouterGuideProtocol {
    
    // MARK: Static methods
    static func createModule(vc: GuideVC) {
        
        let presenter: ViewToPresenterGuideProtocol & InteractorToPresenterGuideProtocol = GuidePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = GuideRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = GuideInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
    
    func loadVideo(videoURL: String, navigationController: UINavigationController) {
        let url: URL = URL(string: videoURL)!
        let playerView = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = playerView
        DispatchQueue.main.async {
            navigationController.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }
    }
}
