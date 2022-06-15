//
//  SearchLocationVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 24/06/21.
//

import UIKit
import CoreLocation
import DropDown

protocol searchLocationLatLongDelegateProtocol
{
    func sendSearchLocationLatLong(strLat: String, strLong: String, strAddress: String,strCheckFromSearchLocation: String)
}

class SearchLocationVC: UIViewController
{
    var delegate: searchLocationLatLongDelegateProtocol? = nil
    @IBOutlet var Mainview: UIView!
    
    @IBOutlet var viewRecentlySearched: UIView!
    
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tblViewSearch: UITableView!
    @IBOutlet weak var lblNoRecentSearch: UILabel!
    
    @IBOutlet var consResentSearchViewH: NSLayoutConstraint!
    
    var search : String = ""
    var isActiveSearch : Bool = false
    var arrSearchData = NSArray()
    var arrHistoryData = NSMutableArray()
    var indexLocationSearch : Int!
    let dropDown = DropDown()
    
    var checkFlagCurrentLocationORNot = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("FLAG",checkFlagCurrentLocationORNot)
        self.setUIOnScreen()
        
        if UserDefaults.standard.value(forKey: "searchHistory") != nil
        {
            
            let arrHis = UserDefaults.standard.value(forKey: "searchHistory") as! NSArray
            arrHistoryData = arrHis.mutableCopy() as! NSMutableArray
            
            /*
             if self.arrSearchData.count > 0
             {
             self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
             if #available(iOS 13.0, *) {
             self.Mainview.backgroundColor = UIColor.systemBackground
             } else {
             // Fallback on earlier versions
             }
             // self.tblViewSearch.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
             }
             else
             {
             self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
             if #available(iOS 13.0, *) {
             self.Mainview.backgroundColor = UIColor(named: Color_N_Light100)
             } else {
             // Fallback on earlier versions
             }
             // self.tblViewSearch.backgroundColor = UIColor(named:Color_N_Light100)
             }
             */
            if arrHistoryData.count == 0
            {
                
                self.lblNoRecentSearch.text = "NO RECENTLY SEARCHED"
                self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
                if #available(iOS 13.0, *) {
                    self.Mainview.backgroundColor = UIColor(named: Color_N_Light100)
                } else {
                    // Fallback on earlier versions
                }
            }
            else
            {
                self.lblNoRecentSearch.text = "RECENTLY SEARCHED"
                self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
                if #available(iOS 13.0, *) {
                    self.Mainview.backgroundColor = UIColor.systemBackground
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            self.lblNoRecentSearch.text = "NO RECENTLY SEARCHED"
            // self.lblNoRecentSearch.text = "NO RECENTLY SEARCHED"
            self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
            if #available(iOS 13.0, *) {
                self.Mainview.backgroundColor = UIColor(named: Color_N_Light100)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if arrHistoryData.count != 0 {
            
            UserDefaults.standard.setValue(arrHistoryData, forKey: "searchHistory")
            UserDefaults.standard.synchronize()
        }
        else {
            UserDefaults.standard.setValue(nil, forKey: "searchHistory")
            UserDefaults.standard.synchronize()
        }
    }
    
    // ********** All Button Actions ********** //
    
    @IBAction func btnSearchClicked(_ sender: Any)
    {
        
    }
    @IBAction func ActionBack(_ sender: UIButton)
    {
       /* self.delegate?.sendSearchLocationLatLong(strLat: "", strLong: "", strAddress: "", strCheckFromSearchLocation: "FromCurrentLocation")*/
        
        let viewControllers = self.navigationController!.viewControllers
       // print(indexLocationSearch!)
        for aViewController in viewControllers
          {
              print(aViewController)
            if aViewController is HomeVC
            {
               let aVC = aViewController as! HomeVC
                if indexLocationSearch == nil
                {
                    indexLocationSearch = 0
                }
                else
                {
                    print(indexLocationSearch as Any)
                    aVC.Currentindex = indexLocationSearch
                }
                
                aVC.BackFromSearck = "Back"
                aVC.strSearchAddress = ""
                aVC.strSearchLat = ""
                aVC.strSearchLog = ""
                aVC.forHomeReload = false
                self.navigationController?.popToViewController(aVC, animated: true)
            }
            else
            {
                
                self.navigationController?.popViewController(animated: false)
                print("NOT HOME")
            }
        }
        
       // self.navigationController?.popViewController(animated: true)
        
        /*
         var index : Int!
         
         let viewControllers = self.navigationController!.viewControllers
         print(index!)
         for aViewController in viewControllers
           {
               print(aViewController)
              if aViewController is HomeVC
              {
                 let aVC = aViewController as! HomeVC
                  aVC.FromSelectBike = index
                 _ = self.navigationController?.popToViewController(aVC, animated: true)
              }
           }
         
         */
       
    }
    
    @IBAction func ActionUseMyCurrentLocation(_ sender: UIButton)
    {
       /* self.delegate?.sendSearchLocationLatLong(strLat: "", strLong: "", strAddress: "", strCheckFromSearchLocation: "")*/
        
        let viewControllers = self.navigationController!.viewControllers
       // print(indexLocationSearch!)
        for aViewController in viewControllers
          {
            //  print(aViewController)
            if aViewController is HomeVC
            {
               let aVC = aViewController as! HomeVC
                
                if indexLocationSearch == nil
                {
                    indexLocationSearch = 0
                }
                else
                {
                    print(indexLocationSearch as Any)
                    aVC.Currentindex = indexLocationSearch
                }
                
                aVC.BackFromSearck = "CurrentLocation"
                
                aVC.strSearchAddress = ""
                aVC.strSearchLat = ""
                aVC.strSearchLog = ""
                aVC.forHomeReload = false
                self.navigationController?.popToViewController(aVC, animated: true)
            }
            else
            {
                
                self.delegate?.sendSearchLocationLatLong(strLat: "", strLong: "", strAddress: "", strCheckFromSearchLocation: "")
                self.navigationController?.popViewController(animated: false)
            }
        }
        
      //  self.navigationController?.popViewController(animated: true)
    }

}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension SearchLocationVC {
    
    func setUIOnScreen() {
        
        
    }
    
}

// ************************************ //
// MARK:- UITextField Delegate Methos
// ************************************ //
extension SearchLocationVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            search = String(search.dropLast())
        }
        else {
            search = textField.text!+string
        }
        
        if search.isEmpty {
            
            isActiveSearch = false
            consResentSearchViewH.constant = 16
            print("Empty")
            
            tblViewSearch.backgroundColor = UIColor.clear
            
            tblViewSearch.reloadData()
        }
        else {
            
            consResentSearchViewH.constant = 0
            if #available(iOS 13.0, *) {
                self.searchGooglePlaceAPICall(strSearch: search)
            } else {
                // Fallback on earlier versions
            }
        }
        
        print(search)
        
        return true
    }
    
}

// ************************************ //
// MARK:- UITableView Delegate Methos
// ************************************ //
extension SearchLocationVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isActiveSearch == true {
            
            return arrSearchData.count
        }
        else {
            
            return arrHistoryData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isActiveSearch == true {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellID1") as! SearchLocationTblCell
            
            let dicAddress = arrSearchData[indexPath.row] as! [String: Any]
            
            let dicStructure = dicAddress["structured_formatting"] as! [String: Any]
            
            cell.lblAddress.text = "\(dicStructure["secondary_text"] as? String ?? "")"
            
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! SearchLocationTblCell
           
            let dicAddress = arrHistoryData[indexPath.row] as! String
            cell.lblAddress.text = dicAddress
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isActiveSearch == true {
            
            let dicAddress = arrSearchData[indexPath.row] as! [String: Any]
            
            print(dicAddress)
            let dicStructure = dicAddress["structured_formatting"] as! [String: Any]
            
            let strStringAddress  = dicStructure["secondary_text"] as? String ?? ""
         
            if self.arrHistoryData.count == 15
            {
                if arrHistoryData.contains(strStringAddress)
                {
                    print("REmove")
                }
                else
                {
                   
                    self.arrHistoryData.removeLastObject()
                    self.arrHistoryData.insert(strStringAddress, at: 0)
                }
                
            }
            else
            {
                if arrHistoryData.contains(strStringAddress)
                {
                    print("REmove")
                }
                else
                {
                   // self.arrHistoryData.removeLastObject()
                    self.arrHistoryData.insert(strStringAddress, at: 0)
                }
            }
            
            self.getLatLongGooglePlaceAPICall(strSearch: strStringAddress)
            
            
        }
        else {
            
            let dicAddress = arrHistoryData[indexPath.row] as! String
            print(dicAddress)
            
            //   let dicStructure = dicAddress["structured_formatting"] as! [String: Any]
            self.getLatLongGooglePlaceAPICall(strSearch: dicAddress)
        }
        
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension SearchLocationVC {
    
    @available(iOS 13.0, *)
    func searchGooglePlaceAPICall(strSearch: String) {
        
        let param = ["language":"en", "input":"\(strSearch)", "types":"address", "key":"\(mapDirectionAPIKey)"]
        
        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        
        var components = URLComponents(string: urlString)
        components?.queryItems = param.map({ URLQueryItem(name: $0, value: $1)})
        
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("GooglePlaces Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("GooglePlaces Error: No response from API")
                return
            }
            
            guard response.statusCode == 200 else {
                print("GooglePlaces Error: Invalid status code \(response.statusCode) from API")
                return
            }
            
            let object: NSDictionary?
            do {
                object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            } catch {
                object = nil
                print("GooglePlaces Error")
                return
            }
            
            guard object?["status"] as? String == "OK" else {
                print("GooglePlaces API Error: \(object?["status"] ?? "")")
                return
            }
            
            guard let json = object else {
                print("GooglePlaces Parse Error")
                return
            }
            
            // Perform table updates on UI thread
            DispatchQueue.main.async {
                print(json)
                self.isActiveSearch = true
                self.arrSearchData = json["predictions"] as! NSArray
                
                //   print(self.arrSearchData)
                
                
                
                if self.arrSearchData.count > 0
                {
                    self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
                    if #available(iOS 13.0, *) {
                        self.Mainview.backgroundColor = UIColor.systemBackground
                    } else {
                        // Fallback on earlier versions
                    }
                    // self.tblViewSearch.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                }
                else
                {
                    self.viewRecentlySearched.backgroundColor = UIColor(named: Color_N_Light100)
                    if #available(iOS 13.0, *) {
                        self.Mainview.backgroundColor = UIColor(named: Color_N_Light100)
                    } else {
                        // Fallback on earlier versions
                    }
                    // self.tblViewSearch.backgroundColor = UIColor(named:Color_N_Light100)
                }
                self.tblViewSearch.reloadData()
            }
        })
        
        task.resume()
        
    }
    
    func getLatLongGooglePlaceAPICall(strSearch: String) {
        
        let param = ["query":"\(strSearch)", "key":"\(mapDirectionAPIKey)"]
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        
        var components = URLComponents(string: urlString)
        components?.queryItems = param.map({ URLQueryItem(name: $0, value: $1)})
        
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                print("GooglePlaces Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("GooglePlaces Error: No response from API")
                return
            }
            
            guard response.statusCode == 200 else {
                print("GooglePlaces Error: Invalid status code \(response.statusCode) from API")
                return
            }
            
            let object: NSDictionary?
            do {
                object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            } catch {
                object = nil
                print("GooglePlaces Error")
                return
            }
            
            guard object?["status"] as? String == "OK" else {
                print("GooglePlaces API Error: \(object?["status"] ?? "")")
                return
            }
            
            guard let json = object else {
                print("GooglePlaces Parse Error")
                return
            }
            
            // Perform table updates on UI thread
            DispatchQueue.main.async { [self] in
                print(json)
                let results = json["results"] as! NSArray
                print(results)
                if results.count != 0 {
                    let dicMain = results[0] as! [String : Any]
                    let dicGeometry = dicMain["geometry"] as! [String: Any]
                    print("GEOMETRIC",dicGeometry)
                    let dicLocation = dicGeometry["location"] as! [String : Any]
                    print("DICTIONARY LOCATION",dicLocation)
                    
                    print("LAT",dicLocation["lat"] as! Double)
                    print("LONG",dicLocation["lng"] as! Double)
                    
                   // self.delegate?.sendSearchLocationLatLong(strLat: "\(dicLocation["lat"] as! Double)", strLong: "\(dicLocation["lng"] as! Double)", strAddress: strSearch, strCheckFromSearchLocation: "FromSearchLocation")
                    /*
                     var strSearchAddress : String!
                     var strSearchLat : String!
                     var strSearchLog : String!
                     */
                    let viewControllers = self.navigationController!.viewControllers
                   // print(indexLocationSearch!)
                    for aViewController in viewControllers
                      {
                          print(aViewController)
                        if aViewController is HomeVC
                        {
                           let aVC = aViewController as! HomeVC
                            
                            aVC.Currentindex = 0
                            aVC.BackFromSearck = "SearchLocation"
                            aVC.strSearchAddress = strSearch
                            aVC.strSearchLat = "\(dicLocation["lat"] as! Double)"
                            aVC.strSearchLog = "\(dicLocation["lng"] as! Double)"
                            aVC.forHomeReload = false
                            checkFlagCurrentLocationORNot = true
                            
                            self.navigationController?.popToViewController(aVC, animated: true)
                        }
                        else
                        {
                            self.delegate?.sendSearchLocationLatLong(strLat: "\(dicLocation["lat"] as! Double)", strLong: "\(dicLocation["lng"] as! Double)", strAddress: strSearch, strCheckFromSearchLocation: "FromSearchLocation")
                            self.navigationController?.popViewController(animated: false)
                            print("NOT HOME")
                        }
                    }
                    
                   // self.navigationController?.popViewController(animated: true)
                   // let homeVc = HomeVC()
                  //  homeVc.SearchLocation = "Back"
                  //  UserDefaults.standard.setValue("Location", forKey: "FromSearchLocation")
                  //  UserDefaults.standard.synchronize()
                   // self.indexLocationSearch = 0
                   // let aVC = HomeVC()
                    
                   /* aVC.Currentindex = 0
                    aVC.BackFromSearck = "Search"
                    self.navigationController?.popViewController(animated: true)*/
                   
                }
            }
        })
        
        task.resume()
        
    }
    
    
}




