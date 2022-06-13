//
//  MySubscriptionFetchModel.swift
//  Mybyk
//
//  Created by Gaurav Patel on 12/01/22.
//

import UIKit

struct MySubscriptionSomeData {
    
    let duration: String?
    let end_date: String?
    let freeUsage: String?
    let isTimeBased: String?
    let minAmount: String?
    let payasyougo: String?
    let startDate: String?
    let start_date: String?
    let subAmount: String?
    let subscription_label: String?
    let transaction_id: Int?
    let type: String?
    let statusBackClr: String?
    //    tbDuration =     (
    //        "Every 1 hour(s)  = \U20b9 2"
    //    );
    
    
}


typealias MySubscriptionModelBlock = (_ success:Bool,_ status:String) -> Void

class MySubscriptionFetchModel: NSObject {
    
    var dataArr:Array<MySubscriptionSomeData> = []
    var dataArrTmp:Array<MySubscriptionSomeData> = []
    var dataSearchTempFilter:Array<MySubscriptionSomeData> = []
    
    var currencySymbol = String()
    
    
    func getData(arrRide: [AnyObject], block: MySubscriptionModelBlock) {
        
        for dic in arrRide {
            
            print(dic)
            
            let duration = dic["duration"] as? String ?? ""
            let end_date = dic["end_date"] as? String ?? ""
            let freeUsage = dic["freeUsage"] as? String ?? ""
            let isTimeBased = dic["isTimeBased"] as? String ?? ""
            let minAmount = dic["minAmount"] as? String ?? ""
            let payasyougo = dic["payasyougo"] as? String ?? ""
            let startDate = dic["startDate"] as? String ?? ""
            let start_date = dic["start_date"] as? String ?? ""
            let subAmount = dic["subAmount"] as? String ?? ""
            let subscription_label = dic["subscription_label"] as? String ?? ""
//            let transaction_id = dic["transaction_id"] as? String ?? "\(dic["subscription_label"] as? Int ?? 0)"
            let transaction_id = dic["transaction_id"] as? Int ?? 0
            
            let type = dic["type"] as? String ?? ""
            
            var statusBackClr = String()
            
            
            if subscription_label == "Expired" {
                statusBackClr = Color_N_Light500
            }
            else {
                statusBackClr = Color_Active
            }
            
            let model = MySubscriptionSomeData(duration: duration, end_date: end_date, freeUsage: freeUsage, isTimeBased: isTimeBased, minAmount: minAmount, payasyougo: payasyougo, startDate: startDate, start_date: start_date, subAmount: subAmount, subscription_label: subscription_label, transaction_id: transaction_id, type: type, statusBackClr: statusBackClr)
            
            dataArr.append(model)
           
        }
        dataArrTmp = dataArr
        
        block(true, "success")
    }
    
}
