//
//  SideMenuTableViewCell.swift
//  Medreminder
//
//  Created by MacOS on 02/08/2023.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var menuLblledingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
