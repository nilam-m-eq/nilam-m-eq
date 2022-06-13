//
//  EventListViewModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit

typealias EventCellRenderBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> UITableViewCell?
typealias EventCellSelectBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> Void

class EventListViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cellRender: EventCellRenderBlock!
    var cellSelect: EventCellSelectBlock?
    var sectionCount: Int = 0
    var rawCount: Int = 0
    
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
        cellSelect!(indexPath, tableView)
    }
    
}
