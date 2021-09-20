//
//  RestoTableViewCell.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import UIKit

class RestoTableViewCell: UITableViewCell {

    @IBOutlet weak var restoImg: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var isAdedView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        restoImg.layer.masksToBounds = true
        restoImg.layer.cornerRadius = 20

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
