//
//  EventTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit

class EventTblCell: UITableViewCell {
    @IBOutlet weak var viewBackMain: UIView!
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
