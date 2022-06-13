//
//  SelectBikeTblHeaderCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 26/10/21.
//

import UIKit

class SelectBikeTblHeaderCell: UITableViewCell {
    @IBOutlet var lblTblHeaderName: UILabel!

    @IBOutlet var imgArrowImageChanged: UIImageView!
    @IBOutlet var viewSectionMainCorner: UIView!
    @IBOutlet var btnArrowExpand: UIButton!
    @IBOutlet var btnArrowImageChange: UIButton!
    @IBOutlet var imgLikeDislikeThumb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
