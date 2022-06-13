//
//  MyRidesTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 26/06/21.
//

import UIKit

class MyRidesTblCell: UITableViewCell {
    @IBOutlet weak var viewBackMain: UIView!
    @IBOutlet weak var lblRideID: UILabel!
    @IBOutlet weak var lblRideStatus: UIButton!
    @IBOutlet weak var lblRideAmount: UILabel!
    @IBOutlet weak var lblRideDate: UILabel!
    @IBOutlet weak var lblRideDuration: UILabel!
    
    @IBOutlet var lblbDuration: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBackMain.shadowZ100(frame: viewBackMain.frame)
            //  viewBackMain.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
