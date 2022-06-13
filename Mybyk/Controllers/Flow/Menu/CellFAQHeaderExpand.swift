//
//  CellFAQHeaderExpand.swift
//  Mybyk
//
//  Created by Parth Kapadia on 21/03/22.
//

import UIKit

class CellFAQHeaderExpand: UITableViewCell {

    @IBOutlet var btnSetImageExpandCollapse: UIButton!
    @IBOutlet var viewSction: UIView!
    @IBOutlet var btnExpand: UIButton!
    @IBOutlet var viewSectionLine: UIView!
    @IBOutlet var lbHeaderTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //let border = CALayer()
       // border.backgroundColor = UIColor.lightGray.cgColor
        //border.frame = CGRect(x: 0, y: viewSction.frame.height, width: viewSction.frame.width, height: 1)
       // self.viewSction.layer.addSublayer(border)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
