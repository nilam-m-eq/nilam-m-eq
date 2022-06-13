//
//  SelectBikeTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit

class SelectBikeTblCell: UITableViewCell {
    @IBOutlet var viewBottomGray: UIView!
    @IBOutlet weak var viewBackMain: UIView!
    @IBOutlet var lblLockNumber: UILabel!
    @IBOutlet var imgViewCycleIcon: UIImageView!
    @IBOutlet var viewBottomGrayConstant: NSLayoutConstraint!
    
    @IBOutlet var viewGrayHeightConstant: NSLayoutConstraint!
    @IBOutlet var viewBottomGrayCell: NSLayoutConstraint!
    
    var setConstraint : Bool?
    
    override func awakeFromNib()
    {
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
