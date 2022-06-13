//
//  CellFAQDetailCollapse.swift
//  Mybyk
//
//  Created by Parth Kapadia on 21/03/22.
//

import UIKit

protocol TableViewCellDelegate
{
        func BtnExpendTapped(_ cell: CellFAQDetailCollapse)
}

class CellFAQDetailCollapse: UITableViewCell {

    @IBOutlet var btnCollapse: UIButton!
    @IBOutlet var lbDetails: UILabel!
    @IBOutlet var viewMainOuter: UIView!
    
    var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
