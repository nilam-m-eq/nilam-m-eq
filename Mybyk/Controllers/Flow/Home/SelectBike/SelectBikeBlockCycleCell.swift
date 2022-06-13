//
//  SelectBikeBlockCycleCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 28/03/22.
//

import UIKit

class SelectBikeBlockCycleCell: UITableViewCell {

    @IBOutlet var viewBottomGrayConstant: NSLayoutConstraint!
    @IBOutlet var viewHeightConst: NSLayoutConstraint!
    @IBOutlet var viewBottomGrayConst: NSLayoutConstraint!
    @IBOutlet var viewBottomGray: UIView!
    @IBOutlet var viewMain: UIView!
    @IBOutlet var imgCycle: UIImageView!
    @IBOutlet var lbLockNumber: UILabel!
    var setConstraint : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if setConstraint == true
        {
           
        }
        else
        {
           
        }
     //   viewBackMain.clipsToBounds = true
     //   viewBackMain.shadowZ100(frame: viewBackMain.frame)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
