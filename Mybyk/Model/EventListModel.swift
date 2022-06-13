//
//  EventListModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit

struct EventListSomeData {
    
    let strEventTitle: String?
    let strEventDescription: String?
    let IdEvent: String?
//    let strEventDate: String?
//    let strEventStatus: String?
//    let strEventIcon: String?
    
}



typealias EventListModelBlock = (_ success:Bool,_ status:String) -> Void
class EventListModel: NSObject {
    
    var dataArr: Array<EventListSomeData> = []
    
    func getEventData(arrEvent: [AnyObject], block: EventListModelBlock) {
        
        
        if dataArr.count == 0
        {
            
        }
        else
        {
            dataArr.removeAll()
        }
        for dic in arrEvent
        {
            let title = dic["eventName"] as? String ?? ""
            let desc = dic["eventShortDescription"] as? String ?? ""
            print(dic["eventID"] as? String ?? "")
            let ID = dic["eventID"] as? String ?? ""
//            let status = dic["event_Status"]
//            let date = dic["event_Date"]
//            var icon = String()
//            icon = "IC_Event"
            
            
            let model = EventListSomeData(strEventTitle: title, strEventDescription: desc, IdEvent: ID)
            dataArr.append(model)
            
          /*  if dataArr.count == 0
            {
                
            }
            else
            {
                if let i = dataArr.firstIndex(where: { $0.IdEvent == ID })
                {
                    print("get the \(i)")
                    
                }
                
               
            }*/
            
//            let model = EventListSomeData(strEventTitle: title, strEventDescription: desc, strEventDate: date, strEventStatus: status, strEventIcon: icon)
           // dataArr = mo
            
        }
        block(true, "success")
    }

}
