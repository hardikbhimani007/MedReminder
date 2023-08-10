//
//  SideMenuViewController.swift
//  Medreminder
//
//  Created by MacOS on 02/08/2023.
//

import UIKit
import SwiftUI

class SideMenuViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var tableViewMenu: UITableView!
    //MARK: - Properties
    var arrMenu1 = [Menu]()
    var arrMenu2 = [Menu]()
    var arrMenu3 = [Menu]()
    var arrMenu4 = [Menu]()
    let arrImage: [String] = ["share","user","align"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibRegister()
        loadData()
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewMenu.reloadData()
    }
    
    //MARK: - Functions
    func nibRegister() {
        tableViewMenu.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        tableViewMenu.separatorStyle = .none
    }
    
    func loadData() {
        let list1 = Menu(SideMenuName: "\(localized(key: "Profile"))")
        let list2 = Menu(SideMenuName: "\(localized(key: "Measurements"))")
        let list3 = Menu(SideMenuName: "\(localized(key: "Notes"))")
        let list4 = Menu(SideMenuName: "\(localized(key: "Appointments"))")
        let list5 = Menu(SideMenuName: "\(localized(key: "Doctors"))")
        let list6 = Menu(SideMenuName: "\(localized(key: "Refills"))")
        let list7 = Menu(SideMenuName: "\(localized(key: "Track Health"))")
        let list8 = Menu(SideMenuName: "\(localized(key: "Medicine information"))")
        arrMenu1 = [list1, list2, list3, list4, list5, list6, list7, list8]
        
        let list9 = Menu(SideMenuName: "\(localized(key: "Change language"))")
        let list10 = Menu(SideMenuName: "\(localized(key: "Theme"))")
        arrMenu2 = [list9, list10]
        
        let list11 = Menu(SideMenuName: "\(localized(key: "Share your progress"))")
        let list12 = Menu(SideMenuName: "\(localized(key: "Invite friends and family"))")
        let list13 = Menu(SideMenuName: "\(localized(key: "Enter Invaitation code"))")
        arrMenu3 = [list11, list12, list13]
        
        let list14 = Menu(SideMenuName: "\(localized(key: "Customer service"))")
        let list15 = Menu(SideMenuName: "\(localized(key: "Help and support"))")
        arrMenu4 = [list14, list15]
    }
    //MARK: - Button Actions
    @objc func tappedCancelBtn() {
        let transition:CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: true)
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return arrMenu1.count
        case 1: return arrMenu2.count
        case 2: return arrMenu3.count
        case 3: return arrMenu4.count
        default: return arrMenu1.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        if indexPath.section == 0 {
            cell.menuLbl.text = arrMenu1[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = true
            if indexPath.row == arrMenu1.count - 1 {
                cell.lineLbl.isHidden = false
            }
        } else  if indexPath.section == 1 {
            cell.menuLbl.text = arrMenu2[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = true
            if indexPath.row == arrMenu2.count - 1 {
                cell.lineLbl.isHidden = false
            }
        } else  if indexPath.section == 2 {
            cell.menuLbl.text = arrMenu3[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = false
            cell.imgViewLeadingConstraint.constant = 30
            cell.menuImgView.image = UIImage(named: arrImage[indexPath.row])
            if indexPath.row == arrMenu3.count - 1 {
                cell.lineLbl.isHidden = false
            }
        } else  if indexPath.section == 3 {
            cell.menuLbl.text = arrMenu4[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = true
            if indexPath.row == arrMenu4.count - 1 {
                cell.lineLbl.isHidden = true
            }
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

