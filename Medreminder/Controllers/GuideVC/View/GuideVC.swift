//
//  GuideVC.swift
//  Medreminder
//
//  Created by MacOS on 01/08/2023.
//

import UIKit
import AVKit
import AVFoundation

class GuideVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableViewGuide: UITableView!
    
    // MARK: - Properties
    var presenter: ViewToPresenterGuideProtocol?
    var arrGuide = [Guide]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GuideRouter.createModule(vc: self)
        navigationController?.navigationBar.isHidden = true
        presenter?.showRegisterNib(tableView: tableViewGuide, nibName: "GuideTableViewCell", forCellReuseIdentifier: "GuideTableViewCell")
        volumeBtn.addTarget(self, action: #selector(tappedvolumeBtn), for: .touchUpInside)
        documentBtn.addTarget(self, action: #selector(tappedDocumnetBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableViewGuide.reloadData()
    }
    
    //MARK: - Actions
    @objc func tappedvolumeBtn() {
        presenter?.showPuchVC(storyBoardName: "Home", withIdentifier: "SoundVC", navigationController: navigationController!)
    }
    
    @objc func tappedDocumnetBtn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController!.view.layer.add(transition, forKey: nil)
        presenter?.showPuchVC(storyBoardName: "Home", withIdentifier: "SideMenuViewController", navigationController: navigationController!)
    }
   
    func loadData() {
        presenter?.fetchData()
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource & AVPlayerViewControllerDelegate
extension GuideVC: UITableViewDelegate, UITableViewDataSource, AVPlayerViewControllerDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGuide.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GuideTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GuideTableViewCell") as! GuideTableViewCell
        let guide = arrGuide[indexPath.row]
        cell.comminInit(guide: guide.name, videoURL: guide.videoURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 206
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showVideo(videoURL: arrGuide[indexPath.row].videoURL, navigationController: navigationController!)
    }
}

extension GuideVC: PresenterToViewGuideProtocol{
    // TODO: Implement View Output Methods
    func showData(arrGuide: [Guide]) {
        self.arrGuide = arrGuide
        self.tableViewGuide.reloadData()
    }
}
