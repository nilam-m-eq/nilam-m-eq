//
//  MySubscriptionViewModel.swift
//  Mybyk
//
//  Created by Gaurav Patel on 12/01/22.
//

import UIKit

typealias MySubscriCellRenderBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> UITableViewCell?
typealias MySubscriCellSelectBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> Void

class MySubscriptionViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {

    var cellRender: MySubscriCellRenderBlock!
    var cellSlect: MySubscriCellSelectBlock?
    var sectionCount:Int = 0
    var rawCount:Int = 0
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cellRender(indexPath, tableView)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellSlect!(indexPath, tableView)
    }
    
}
