//
//  MyRideFetchModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 26/06/21.
//

import UIKit

struct MyRideSomeData {
    
    let duration: String?
    let SIN: String?
    let categoryName: String?
    let charges: Int?
    let deposited: String?
    let deposited_time: String?
    let idCycle: Int?
    let lock_QR_code: String?
    let lock_number: String?
    let no: Int?
    let rented: String?
    let rented_time: String?
    let rideID: Int?
    let ride_end_date: String?
    let ride_start_date: String?
    let ride_status: String?
    let terminal_drop: String?
    let terminal_pickup: String?
    let time_unit: String?
    let statusBackClr: String?
}
typealias ModelBlock = (_ success:Bool,_ status:String) -> Void

class MyRideFetchModel: NSObject
{
    var dataArr:Array<MyRideSomeData> = []
    var dataArrTmp:Array<MyRideSomeData> = []
    var dataSearchTempFilter:Array<MyRideSomeData> = []
    
    
    var currencySymbol = String()
    
    func getData(arrRide: [AnyObject], block: ModelBlock) {
        
        for dic in arrRide {
            
            print(dic)
            
            let duration = dic["Duration"] as? String ?? ""
            let SIN = dic["SIN"] as? String ?? ""
//            let categoryID = dic["categoryID"] as? Int ?? 0
            let categoryName = dic["categoryName"] as? String ?? ""
            let charges = dic["charges"] as? Int ?? 0
            let deposited = dic["deposited"] as? String ?? ""
            let deposited_time = dic["deposited_time"] as? String ?? ""
            let idCycle = dic["idCycle"] as? Int ?? 0
            let lock_QR_code = dic["lock_QR_code"] as? String ?? ""
            let lock_number = dic["lock_number"] as? String ?? ""
            let no = dic["no"] as? Int ?? 0
            let rented = dic["rented"] as? String ?? ""
            let rented_time = dic["rented_time"] as? String ?? ""
            let rideID = dic["rideID"] as? Int ?? 0
            let ride_end_date = dic["ride_end_date"] as? String ?? ""
            let ride_status = dic["ride_status"] as? String ?? ""
            let terminal_drop = dic["terminal_drop"] as? String ?? ""
            let terminal_pickup = dic["terminal_pickup"] as? String ?? ""
            let time_unit = dic["time_unit"] as? String ?? ""
            let ride_start_date = dic["ride_start_date"] as? String ?? ""
            
            var statusBackClr = String()
            
            
            if ride_status == "Completed" {
                statusBackClr = Color_N_Light500
            }
            else {
                statusBackClr = Color_Active
            }
            
            let model = MyRideSomeData(duration: duration, SIN: SIN, categoryName: categoryName, charges: charges, deposited: deposited, deposited_time: deposited_time, idCycle: idCycle, lock_QR_code: lock_QR_code, lock_number: lock_number, no: no, rented: rented, rented_time: rented_time, rideID: rideID, ride_end_date: ride_end_date, ride_start_date: ride_start_date, ride_status: ride_status, terminal_drop: terminal_drop, terminal_pickup: terminal_pickup, time_unit: time_unit, statusBackClr: statusBackClr)
            
            dataArr.append(model)
            
            dataArrTmp = dataArr
        }
        block(true, "success")
    }
    
    
}





