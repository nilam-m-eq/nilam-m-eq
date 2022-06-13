//
//  HomeRequestedHub.swift
//  Mybyk
//
//  Created by Parth Kapadia on 27/04/22.
//

import UIKit

class HomeRequestedHub: UIViewController {

    @IBOutlet var btnRequestHub: UIButton!
    @IBOutlet var lbDesc: UILabel!
    var consMapViewBottomRequestHub: NSLayoutConstraint!
    
    var partialView: CGFloat = UIScreen.main.bounds.height
    
    var strDetail = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        btnRequestHub.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        btnRequestHub.layer.cornerRadius = 5.0
        self.view.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 15.0)
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let frame = self.view.frame
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
       
            let heightLAbel = self!.heightForView(text: self!.strDetail, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self!.view.frame.width - 40)
            
            print(self!.partialView)
            print(self?.strDetail)
            self!.lbDesc.text = self?.strDetail
            self!.partialView = self!.partialView - (250 + heightLAbel)
            let yComponent = self!.partialView
         //   self?.view.backgroundColor = .red
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height - 48)
           // self!.consMapViewBottomRequestHub.constant = 200 + heightLAbel
            self!.consMapViewBottomRequestHub.constant = 250 + heightLAbel - 48
        })
        
     //   400 - 130
        //270
        // 420-48
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnRequestHubClick(_ sender: Any)
    {
        let requestHub = self.storyboard?.instantiateViewController(withIdentifier: "RequestHUBPinVC") as! RequestHUBPinVC
     //   requestHub.fromDic = self.dicStore
        //fromDic
        self.navigationController?.pushViewController(requestHub, animated: true)
    }
    
}
extension HomeRequestedHub
{
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
