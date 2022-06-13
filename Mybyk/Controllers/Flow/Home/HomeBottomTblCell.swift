//
//  HomeBottomTblCell.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit

class HomeBottomTblCell: UITableViewCell {
    @IBOutlet weak var viewMainBack: UIView!
    @IBOutlet weak var lblHubName: UILabel!
    @IBOutlet weak var lblAvailableCycle: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblWalkTime: UILabel!
    @IBOutlet weak var viewBackRestrictedHub: UIView!
  //  @IBOutlet weak var lblRestrictedHub: UILabel!
    @IBOutlet var imgRestrictedHub: UIImageView!
    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet var viewLeftLocation: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //viewMainBack.shadowZ100(frame: viewMainBack.frame)
        
        
        
        viewLeftLocation.clipsToBounds = true
        viewLeftLocation.layer.cornerRadius = 8.0
      /*  viewMainBack.layer.shadowColor = UIColor.lightGray.cgColor
        viewMainBack.layer.cornerRadius = 10.0
        viewMainBack.layer.shadowOffset = .zero
        viewMainBack.layer.shadowRadius = 5.0
        viewMainBack.layer.shadowOpacity = 1.0
        viewMainBack.layer.cornerRadius = 3
        viewMainBack.layer.borderWidth = 1
        viewMainBack.layer.borderColor = UIColor(named: Color_Primary)?.cgColor*/

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
