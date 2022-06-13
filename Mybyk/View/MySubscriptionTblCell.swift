//
//  MySubscriptionTblCell.swift
//  Mybyk
//
//  Created by Gaurav Patel on 12/01/22.
//

import UIKit

class MySubscriptionTblCell: UITableViewCell {
    @IBOutlet weak var viewBackMain: UIView!
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblSubscriptionStatus: UIButton!
    @IBOutlet weak var lblSubsciptionAmount: UILabel!
    @IBOutlet weak var lblSubscriptionTransID: UILabel!
    @IBOutlet weak var lblSubscriptionEndDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBackMain.shadowZ100(frame: viewBackMain.frame)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
