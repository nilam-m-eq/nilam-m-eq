//
//  SubscriptionTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/12/21.
//

import UIKit

class SubscriptionTblCell: UITableViewCell
{
    @IBOutlet var viewBackMain: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet weak var lblOldAmount: UILabel!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblDuration: UILabel!
    
    @IBOutlet var stackview: UIStackView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        stackview.sizeToFit()
        stackview.layoutIfNeeded()
        viewBackMain.layer.shadowColor = UIColor.lightGray.cgColor
        viewBackMain.layer.masksToBounds = false
        viewBackMain.layer.cornerRadius = 5.0
        viewBackMain.layer.shadowOffset = CGSize(width: -1, height: 3)
        viewBackMain.layer.shadowOpacity = 0.5
        viewBackMain.translatesAutoresizingMaskIntoConstraints = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
