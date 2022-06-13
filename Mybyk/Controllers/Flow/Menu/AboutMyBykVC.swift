//
//  AboutMyBykVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 06/04/22.
//

import UIKit
import WebKit

class AboutMyBykVC: UIViewController {

    @IBOutlet var webview: WKWebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = true
      //  webview.frame = CGRect(x: 0 , y: 0 - 8, width: self.view.bounds.size.width, height: self.view.bounds.size.height + 14)

     //   webview.scrollView.frame = CGRect(x: 0 , y: 0 - 8, width: self.view.bounds.size.width, height: self.view.bounds.size.height + 14)
        
       // webview.scrollView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        //UIEdgeInsetsMake(64,0,0,0)
        
        self.loadUrl()

        // Do any additional setup after loading the view.
    }   
    @IBAction func btnBackClicked(_ sender: Any)
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
extension AboutMyBykVC : WKNavigationDelegate
{
    func loadUrl() -> Void
    {
        //https://ma.greenpedia.in/aboutus.php  Live
        //"https://staging.ma.greenpedia.in/aboutus.php" Stagging
        
        let myBlog = "https://ma.greenpedia.in/aboutus.php"
        let url = NSURL(string: myBlog)
        let request = NSURLRequest(url: url! as URL)
        webview.navigationDelegate = self
      //  webview.translatesAutoresizingMaskIntoConstraints = false
      //  webview.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        webview.load(request as URLRequest)
    }
}
