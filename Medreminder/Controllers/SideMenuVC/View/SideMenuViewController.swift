//
//  SideMenuViewController.swift
//  Medreminder
//
//  Created by MacOS on 02/08/2023.
//

import UIKit

class SideMenuViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var tableViewMenu: UITableView!
    // MARK: - Properties
    var presenter: ViewToPresenterSideMenuProtocol?
    var arrMenu1 = [Menu]()
    var arrMenu2 = [Menu]()
    var arrMenu3 = [Menu]()
    var arrMenu4 = [Menu]()
    let arrImage: [String] = ["share","user","align"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuRouter.createModule(vc: self)
        presenter?.showRegisterNib(tableView: tableViewMenu)
        presenter?.loadedDataShow()
        cancelBtn.addTarget(self, action: #selector(tappedCancelBtn), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewMenu.reloadData()
    }
    //MARK: - Button Actions
    @objc func tappedCancelBtn() {
        presenter?.showVC(navigationController: navigationController!)
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
        presenter?.cellForRowAt(tableView: tableView, arrMenu1: arrMenu1, arrMenu2: arrMenu2, arrMenu3: arrMenu3, arrMenu4: arrMenu4, arrImage: arrImage, indexPath: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SideMenuViewController: PresenterToViewSideMenuProtocol{
    // TODO: Implement View Output Methods
    func showData(arrMenu1: [Menu], arrMenu2: [Menu], arrMenu3: [Menu], arrMenu4: [Menu]) {
        self.arrMenu1 = arrMenu1
        self.arrMenu2 = arrMenu2
        self.arrMenu3 = arrMenu3
        self.arrMenu4 = arrMenu4
        self.tableViewMenu.reloadData()
    }
}
