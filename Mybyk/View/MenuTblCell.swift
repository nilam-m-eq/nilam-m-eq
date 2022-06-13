//
//  MenuTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

class MenuTblCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imgForwardArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
