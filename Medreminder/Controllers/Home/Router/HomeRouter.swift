//
//  HomeRouter.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
//  
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    // MARK: Static methods
    static func createModule(vc: HomeVC) {
        
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = HomeRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = HomeInteractor()
        vc.presenter?.interactor?.presenter = presenter
    }
    
    func showAlert(names: String ,tableView: UITableView, vc: HomeVC) {
        var name = names
        let alert = UIAlertController(title: "\(localized(key: "Set Name"))", message: "\(localized(key: "Enter your name"))", preferredStyle: .alert)
        alert.addTextField { (txtField) in
            txtField.placeholder = "\(localized(key: "Enter your name"))"
        }
        alert.addAction(UIAlertAction(title: "\(localized(key: "Ok"))", style: .default, handler: { [weak alert] (_) in
            let txtFiled = alert?.textFields?.first
            if let headerView = tableView.headerView(forSection: 0) as? HeaderView {
                headerView.userNameLbl.text = txtFiled?.text
                headerView.userBtn.setTitle(txtFiled?.text, for: .normal)
                UserDefaults.standard.set(txtFiled?.text, forKey: "name")
            }
            print("TxtField:- \(txtFiled?.text ?? "")")
        }))
        let lunchedBefore = UserDefaults.standard.bool(forKey: "HaslunchBefore")
        if lunchedBefore {
           let txtFieldName = UserDefaults.standard.string(forKey: "name") ?? ""
            name = txtFieldName
        } else {
            vc.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "HaslunchBefore")
        }
    }
    
    func pushToVC(storyBoardName: String, withIdentifier: String, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier);
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToTakeMedicineVC(arrMedDetalis: [MedicineDetalis], indexPath: IndexPath, navigationController: UINavigationController) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TakeMedicineVC") as! TakeMedicineVC
        let detalis = arrMedDetalis[indexPath.row]
        vc.medName = detalis.medicineName ?? ""
        vc.medType = detalis.medicineType ?? ""
        vc.firstDose = detalis.firstDose ?? ""
        vc.hr = detalis.hr ?? 0
        vc.min = detalis.min ?? 0
        vc.sec = detalis.sec ?? 0
        vc.isUpdate = true
        vc.index = indexPath.row
        navigationController.pushViewController(vc, animated: true)
    }
}
