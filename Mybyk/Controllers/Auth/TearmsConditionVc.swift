//
//  TearmsConditionVc.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/03/22.
//

import UIKit
import WebKit

class TearmsConditionVc: UIViewController
{

    @IBOutlet var viewNavigation: UIView!
    @IBOutlet var wbDisplay: WKWebView!
    var strConditionURL : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        viewNavigation.shadowZ100(frame: viewNavigation.frame)
        let request = URLRequest(url: URL(string: strConditionURL)!)
        wbDisplay?.load(request)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackCkiced(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
