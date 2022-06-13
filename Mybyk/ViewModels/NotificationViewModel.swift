//
//  NotificationViewModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

typealias NotifCellRenderBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> UITableViewCell?
typealias NotifCellSelectBlock = (_ indexPath:IndexPath,_ tablleView:UITableView) -> Void

typealias NotifCollectViewCellRenderBlock = (_ indexPath:IndexPath,_ collectionView:UICollectionView) -> UICollectionViewCell?
typealias NotifCollectViewCellSelectBlock = (_ indexPath:IndexPath,_ collectionView:UICollectionView) -> Void

class NotificationViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cellCollectRender: NotifCollectViewCellRenderBlock!
    var cellCollectSelect: NotifCollectViewCellSelectBlock?
    var itemCount: Int = 0
    
    
    var cellRender: NotifCellRenderBlock!
    var cellSelect: NotifCellSelectBlock?
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

extension NotificationViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cellCollectRender(indexPath, collectionView)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellCollectSelect!(indexPath, collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
}
