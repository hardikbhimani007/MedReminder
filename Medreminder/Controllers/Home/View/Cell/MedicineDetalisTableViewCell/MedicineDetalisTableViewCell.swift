//
//  MedicineDetalisTableViewCell.swift
//  Medreminder
//
//  Created by MacOS on 27/07/2023.
//

import UIKit

class MedicineDetalisTableViewCell: UITableViewCell {

    @IBOutlet weak var medicineView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var MedicineNameLbl: UILabel!
    @IBOutlet weak var MedTypeLbl: UILabel!
    @IBOutlet weak var takingLbl: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp(view: medicineView, color: UIColor.cyan, shadowOpacity: 0.1, width: -2, height: -2)
        setUp(view: shadowView, color: UIColor.black, shadowOpacity: 0.2, width: 2, height: 2)
    }
    
    func setUp(view: UIView, color: UIColor, shadowOpacity: Float, width: Int, height: Int) {
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shouldRasterize = true
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = 0.1
        view.layoutIfNeeded()
    }
}
