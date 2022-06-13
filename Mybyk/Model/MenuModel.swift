//
//  MenuModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

struct MenuSomeData {
    
    let strMenuTitle: String?
    
}



typealias MenuModelBlock = (_ success:Bool,_ status:String) -> Void
class MenuModel: NSObject
{
    
    var dataArr: Array<MenuSomeData> = []
    
    func getMenuData(block: MenuModelBlock) {
        
        for val in self.menuData {
            let name = val
            let model = MenuSomeData(strMenuTitle: name)
            dataArr.append(model)
        }
        block(true, "success")
    }
    
   // let buildNumberString =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
    // as! String
     //Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
     //    as! String
   // let strVersion = String(format: "Version %@", Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! CVarArg)
    
    var menuData = [
        //"My Subscription",
        "Request MYBYK Hub",
        "Events",
        "Help and FAQ",
        "Refer a Friend",
        "About MYBYK",
        "Logout"
      //  strVersion
    ]

}



