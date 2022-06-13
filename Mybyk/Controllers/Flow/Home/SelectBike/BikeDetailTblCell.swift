//
//  BikeDetailTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 15/11/21.
//

import UIKit

class BikeDetailTblCell: UITableViewCell {
    
    @IBOutlet var lblPlanName: UILabel!
    @IBOutlet var lblPlanAmount: UILabel!
    @IBOutlet var lblPlanType: UILabel!
    @IBOutlet var lblPlanDes: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
