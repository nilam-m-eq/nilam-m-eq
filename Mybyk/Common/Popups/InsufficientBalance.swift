//
//  InsufficientBalance.swift
//  Mybyk
//
//  Created by Gaurav Patel on 31/12/21.
//

import UIKit
import Foundation

public typealias RechargeInsufficientClosure = () -> Void
public typealias CancelInsufficientClosure = () -> Void

class InsufficientBalance: UIView, UITableViewDelegate, UITableViewDataSource {
    
    static let instance = InsufficientBalance()
    
    @IBOutlet var imgInsufficient: UIImageView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var InsufficientBalanceView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnRecharge: UIButton!
    @IBOutlet var viewWarning: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    public var ActionRecharge: RechargeInsufficientClosure?
    public var ActionCancel: CancelInsufficientClosure?
    
   // var arrTblData = [Any]()
    
    var arrTblData = NSArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("InsufficientBalance", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        btnRecharge.layer.cornerRadius = 6
        btnCancel.layer.cornerRadius = 6
        
        InsufficientBalanceView.layer.cornerRadius = 10
        
        imgInsufficient.image = imgInsufficient.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imgInsufficient.tintColor = UIColor.white
        
        viewWarning.layer.cornerRadius = 30
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.tblView.register(UINib(nibName: "InsufficientTblCell", bundle: nil), forCellReuseIdentifier: "InsufficientTblCell")
        
    }
    
    func showInsufficientBalance(withTblData: NSArray) {
        
        arrTblData = withTblData
        
        tblViewHeight.constant = CGFloat(36 * Int(arrTblData.count))
        
        self.tblView.reloadData()
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    // ************ UITableview Delegate & DataSource *************//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrTblData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsufficientTblCell", for: indexPath) as! InsufficientTblCell
        var CovertID  : String!
        
        let dicTbl = arrTblData[indexPath.row] as! [String: Any]
        print("DICTIONARY",dicTbl)
        
        cell.lblTitle.text = "\(dicTbl["title"] as! String)"
     //   print(dicTbl["bal"]!)
        //print(dicTbl["bal"] as! String)
      
        // let integerValue = (dicTbl["bal"] as! NSNumber).intValue
        
            //print(integerValue)
        

     //   print(dicTbl["bal"] as! Int)
        if let StrStationID = dicTbl["bal"] as? String
        {
            CovertID = StrStationID
        }
        else
        {
            let StrStationIDCovert = dicTbl["bal"]
            CovertID  = "\(StrStationIDCovert as! Int)"
        }
        
        cell.lblAmount.text = "\(dicTbl["symbol"] as! String) \(CovertID ?? "")"
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 36
    }
    
    
    @IBAction func ActionRecharge(_ sender: UIButton) {
        
        parentView.removeFromSuperview()
        ActionRecharge?()
    }
    
    @IBAction func ActionCancel(_ sender: UIButton) {
        
        parentView.removeFromSuperview()
        ActionCancel?()
    }
    
    

}

