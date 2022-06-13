//
//  NotificationModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

struct NotificationSomeData {
    
    let strNotifTitle: String?
    let strNotifMessage: String?
    let strNotifDays: String?
    let strNotifDate: String?
    let strNotifIcon: String?
    
}

typealias NotificationModelBlock = (_ success:Bool,_ status:String) -> Void
class NotificationModel: NSObject
{
    
    var dataArr: Array<NotificationSomeData> = []
    var TmpdataArr: Array<NotificationSomeData> = []
    
    func getNotificationData(arrNotif: [AnyObject], block: NotificationModelBlock)
    {
        
        /*
         for dic in arrNotif
         {
             let title = dic["title"]
             let message = dic["message"]
             let days = dic["days"]
             let date = dic["date"]
             let icon = "IC_TransactionBell"
             
             let model = NotificationSomeData(strNotifTitle: (title as! String), strNotifMessage: (message as! String), strNotifDays: (days as! String), strNotifDate: (date as! String), strNotifIcon: icon)
             
             self.dataArr.append(model)
         }
         */
       
          //  DispatchQueue.main.async
           // {
                arrNotif.forEach
                { dic in
                    print(dic)
                    let title = dic["title"]
                    let message = dic["message"]
                    let days = dic["days"]
                    let date = dic["date"]
                    let icon = "IC_TransactionBell"
                    
                    let model = NotificationSomeData(strNotifTitle: (title as! String), strNotifMessage: (message as! String), strNotifDays: (days as! String), strNotifDate: (date as! String), strNotifIcon: icon)
                    
                    
                    self.dataArr.append(model)
                }
             //TmpdataArr = dataArr
          // }
           
           // TmpdataArr = dataArr
            
      //  }
       
        block(true, "success")
    }
    
}



