//
//  SideMenuInteractor.swift
//  Medreminder
//
//  Created by MacOS on 16/08/2023.
//  
//

import Foundation
import UIKit

class SideMenuInteractor: PresenterToInteractorSideMenuProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterSideMenuProtocol?
    
    func registerNib(tableView: UITableView) {
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        tableView.separatorStyle = .none
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
        
        let list9 = Menu(SideMenuName: "\(localized(key: "Change language"))")
        let list10 = Menu(SideMenuName: "\(localized(key: "Theme"))")
        
        let list11 = Menu(SideMenuName: "\(localized(key: "Share your progress"))")
        let list12 = Menu(SideMenuName: "\(localized(key: "Invite friends and family"))")
        let list13 = Menu(SideMenuName: "\(localized(key: "Enter Invaitation code"))")
        
        let list14 = Menu(SideMenuName: "\(localized(key: "Customer service"))")
        let list15 = Menu(SideMenuName: "\(localized(key: "Help and support"))")
        presenter?.showDataSucessfully(arrMenu1: [list1, list2, list3, list4, list5, list6, list7, list8], arrMenu2: [list9, list10], arrMenu3: [list11, list12, list13], arrMenu4: [list14, list15])
    }
    
    func cellFor(tableView: UITableView, arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu], arrImage: [String], indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        if indexPath.section == 0 {
            cell.menuLbl.text = arrMenu1[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = true
            if indexPath.row == arrMenu1.count - 1 {
                cell.lineLbl.isHidden = false
            }
        } else if indexPath.section == 1 {
            cell.menuLbl.text = arrMenu2[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = true
            if indexPath.row == arrMenu2.count - 1 {
                cell.lineLbl.isHidden = false
            }
        } else if indexPath.section == 2 {
            cell.menuLbl.text = arrMenu3[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = false
            cell.imgViewLeadingConstraint.constant = 30
            cell.menuImgView.image = UIImage(named: arrImage[indexPath.row])
            if indexPath.row == arrMenu3.count - 1 {
                cell.lineLbl.isHidden = false
            }
        } else if indexPath.section == 3 {
            cell.menuLbl.text = arrMenu4[indexPath.row].SideMenuName
            cell.menuImgView.isHidden = true
            if indexPath.row == arrMenu4.count - 1 {
                cell.lineLbl.isHidden = true
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}
