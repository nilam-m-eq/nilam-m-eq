//
//  MyRideViewModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 26/06/21.
//

import UIKit

typealias CellRenderBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> UITableViewCell?
typealias CellSelectBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> Void

class MyRideViewModel: NSObject, UITableViewDelegate, UITableViewDataSource
{
    var cellRender: CellRenderBlock!
    var cellSlect: CellSelectBlock?
    var sectionCount:Int = 0
    var rawCount:Int = 0
    var rowSearch = false
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
//        if rowSearch == false
//        {
//            return sectionCount
//        }
//        else
//        {
//            return 0
//        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if rowSearch == false
//        {
//            return rawCount
//        }
//        else
//        {
//            return 0
//        }
        return rawCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = cellRender(indexPath, tableView)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        cellSlect!(indexPath, tableView)
    }
    
    
}
