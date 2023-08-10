//
//  GuideVC.swift
//  Medreminder
//
//  Created by MacOS on 01/08/2023.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import AudioToolbox

class GuideVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var documentBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableViewGuide: UITableView!
    //MARK: - Properties
    var arrGuide = [Guide]()
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        nibRegister()
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
        let stroyBoard = UIStoryboard(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "SoundVC") as! SoundVC
        self.navigationController?.pushViewController(stroyBoard, animated: true)
    }
    
    @objc func tappedDocumnetBtn() {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func nibRegister() {
        tableViewGuide.register(UINib(nibName: "GuideTableViewCell", bundle: nil), forCellReuseIdentifier: "GuideTableViewCell")
    }
   
    func loadData() {
        let data1 = Guide(name: "\(localized(key: "How to add new medicine?"))", videoURL: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let data2 = Guide(name: "\(localized(key: "How to add new medicine?"))", videoURL: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let data3 = Guide(name: "\(localized(key: "How to add new medicine?"))", videoURL: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        arrGuide = [data1, data2, data3]
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
        playVideo(videoURL: arrGuide[indexPath.row].videoURL)
    }
    
    func playVideo(videoURL: String) {
        let url: URL = URL(string: videoURL)!
        playerView = AVPlayer(url: url)
        playerViewController.player = playerView
        DispatchQueue.main.async {
            self.present(self.playerViewController, animated: true, completion: {
                self.playerViewController.player?.play()
            })
        }
    }
}
