//
//  RequestHUBPinVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 21/01/22.
//

import UIKit
import Toaster
import GoogleMaps
import CoreLocation

class RequestHUBPinVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var viewBackSearch: UIView!
    @IBOutlet weak var lblCurrentAddress: UILabel!
    let marker = GMSMarker()
    var locationManager: CLLocationManager!
    
    var fromDic = [String: Any]()
    
    var strCheckForCurrentLocation = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
       // marker.isDraggable = true
       
        mapView.delegate = self
        marker.isDraggable = true
        marker.map = mapView
        
        //reverseGeocoding(marker: marker)
        //marker.map = mapView
        
        //self.mapView.delegate = self
        //marker.isDraggable = true
        
        self.setUIOnScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
       // UserDefaults.standard.setValue("FromRequestHub", forKey: "ValueRequest")
       // UserDefaults.standard.synchronize()
        
       // strCheckForCurrentLocation = ""
    //    print(UserDefaults.standard.value(forKey: "ValueRequest")!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionSearch(_ sender: UIButton)
    {
        let searchLoc = self.storyboard?.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
        searchLoc.delegate = self
        self.navigationController?.pushViewController(searchLoc, animated: true)
    }
    
    @IBAction func ActionNext(_ sender: UIButton) {
        
        let requestForm = self.storyboard?.instantiateViewController(withIdentifier: "RequestHUBFormVC") as! RequestHUBFormVC
        requestForm.DicDataFromPinVc = fromDic
        self.navigationController?.pushViewController(requestForm, animated: true)
        
    }
    //MARK: - Google Map delegate
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool
    {
        
        self.mapView.clear()
        guard let lat = mapView.myLocation?.coordinate.latitude,
              let lng = mapView.myLocation?.coordinate.longitude else { return false }
        
        
       // let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 18.0)
      //  mapView.animate(to: camera)
        DispatchQueue.main.async
        {
            // 2. Perform UI Operations.
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:lng, zoom: 18.0)
           self.mapView.animate(to: camera)
            self.mapView.setMinZoom(5, maxZoom: 18)
            let marker1 = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            
            let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
            infoWindow.lblCycleCount.isHidden = true
            infoWindow.ingTopConstraint.constant = 15
            marker1.iconView = infoWindow
            
            marker1.map = self.mapView
        }
        
        
        self.GetLocation(lat: lat, Longti: lng)
       // reverseGeocoding(marker: mapView.selectedMarker!)
        /*
         let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:lon, zoom: 18.0)
        self.mapView.animate(to: camera)
         self.mapView.setMinZoom(5, maxZoom: 18)
         let marker1 = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lon))
         
         let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
         marker1.iconView = infoWindow
         
         marker1.map = self.mapView
         */
        /*
         let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 18.0)
         mapView.animate(to: camera)
         */
        return true
        
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker)
    {
        print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
        reverseGeocoding(marker: marker)
        print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
    }
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker)
    {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker)
    {
        print("didDrag")
    }
    //Mark: Reverse GeoCoding
       
    func reverseGeocoding(marker: GMSMarker)
    {
           let geocoder = GMSGeocoder()
           let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
           
           var currentAddress = String()
           
           geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
               if let address = response?.firstResult() {
                   let lines = address.lines! as [String]
                   
                   print("Response is = \(address)")
                   print("Response is = \(lines)")
                   
                   currentAddress = lines.joined(separator: "\n")
                   
               }
            //   marker.title = currentAddress
               self.lblCurrentAddress.text = currentAddress
               marker.map = self.mapView
           }
       }
    func GetLocation(lat : Double,Longti : Double)
    {
           let geocoder = GMSGeocoder()
           let coordinate = CLLocationCoordinate2DMake(lat,Longti)
           
           var currentAddress = String()
           
           geocoder.reverseGeocodeCoordinate(coordinate) { [self] response , error in
               if let address = response?.firstResult() {
                   let lines = address.lines! as [String]
                   
                   print("Response is = \(address)")
                   print("Response is = \(lines)")
                   
                   currentAddress = lines.joined(separator: "\n")
                   
               }
            //   marker.title = currentAddress
               self.lblCurrentAddress.text = currentAddress
               marker.isDraggable = true
              // marker.map = self.mapView
           }
       }

}

// ************************************************** //
// MARK:- Search Location Lat Long Delegate Methods
// ************************************************** //
extension RequestHUBPinVC : searchLocationLatLongDelegateProtocol {
    
    
    func sendSearchLocationLatLong(strLat: String, strLong: String, strAddress: String,strCheckFromSearchLocation:  String) -> Void {
        
        print(strLat)
        print(strLong)
        
        //FromSearchLocation
        //FromCurrentLocation
        
        print(strCheckFromSearchLocation)
        if strLat == ""
        {
            self.mapView.clear()
            guard let lat = mapView.myLocation?.coordinate.latitude,
                  let lng = mapView.myLocation?.coordinate.longitude else { return }
            
            
           // let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 18.0)
          //  mapView.animate(to: camera)
            DispatchQueue.main.async
            {
                // 2. Perform UI Operations.
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:lng, zoom: 18.0)
               self.mapView.animate(to: camera)
                self.mapView.setMinZoom(5, maxZoom: 18)
                let marker1 = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                
                let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                infoWindow.lblCycleCount.isHidden = true
                infoWindow.ingTopConstraint.constant = 15
                marker1.iconView = infoWindow
                
                marker1.map = self.mapView
            }
            
            
            self.GetLocation(lat: lat, Longti: lng)
            //self.locationManager.startUpdatingLocation()
        }
        else
        {
            
            let lat:CLLocationDegrees = Double(strLat)!
            let lon:CLLocationDegrees = Double(strLong)!
            
            
            
            self.lblCurrentAddress.text = strAddress
            self.mapView.clear()
         //   marker.map = nil
            
            print("LATITUDE",lat)
            print("LONGITUDE",lon)
            
           // let marker1 = GMSMarker()
            
    
             //marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
           /* let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
            marker.iconView = infoWindow
            
             let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:lon, zoom: 18.0)
             mapView.animate(to: camera)
            
            marker.map = self.mapView
*/
            DispatchQueue.main.async
            {
                // 2. Perform UI Operations.
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:lon, zoom: 18.0)
               self.mapView.animate(to: camera)
                self.mapView.setMinZoom(5, maxZoom: 18)
                let marker1 = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                
                let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                infoWindow.lblCycleCount.isHidden = true
                infoWindow.ingTopConstraint.constant = 15
                marker1.iconView = infoWindow
                
                marker1.map = self.mapView
            }
            
//             marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
             //marker.title = dicHub["stationName"]! as? String
             //marker.snippet = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
             
             
          /*   let camera = GMSCameraPosition.camera(withLatitude:lat, longitude: lon, zoom: 18.0)
             mapView.animate(to: camera)
             
             var bounds = GMSCoordinateBounds()
             bounds = bounds.includingCoordinate(marker.position)
             let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
             mapView.animate(with: update)
             mapView.setMinZoom(1, maxZoom: 18)
             marker.map = mapView
             
             let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
             infoWindow.lblCycleCount.isHidden = true
          //   infoWindow.lblCycleCount.text = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
            marker.iconView = infoWindow
             
            
      */
          
            
          
         /*   marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            //marker.title = dicHub["stationName"]! as? String
            //marker.snippet = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
            
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:lon, zoom: 18.0)
            mapView.animate(to: camera)
            
            var bounds = GMSCoordinateBounds()
            bounds = bounds.includingCoordinate(marker.position)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
            mapView.animate(with: update)
            mapView.setMinZoom(5, maxZoom: 10)*/
            
       
         /*   let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
            infoWindow.lblCycleCount.isHidden = true
            infoWindow.ingTopConstraint.constant = 15
         //   infoWindow.lblCycleCount.text = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
            marker.iconView = infoWindow
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 18.0)
            mapView.animate(to: camera)
            
            marker.map = self.mapView
            */
           
            
            
           /* let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
            marker.iconView = infoWindow
            marker.map = self.mapView*/
            
        }
        
    }
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension RequestHUBPinVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackSearch.shadowZ100(frame: viewBackSearch.frame)
        btnNext.layer.cornerRadius = 10.0
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.mapType = .normal
        mapView.delegate = self
        
    }
    
}


// MARK: GMSMapViewDelegate
extension RequestHUBPinVC: GMSMapViewDelegate
{
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
    {
        print(coordinate)
        self.mapView.clear()
        
        
        //let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
        infoWindow.lblCycleCount.isHidden = true
        infoWindow.ingTopConstraint.constant = 15
        marker.iconView = infoWindow
     //
        marker.map = self.mapView
        
        self.GetLocation(lat: coordinate.latitude, Longti: coordinate.longitude)
      /*  let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
        marker.iconView = infoWindow
        marker.map = self.mapView*/
        
        
       /* let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 18.0)
        mapView.animate(to: camera)
        
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(marker.position)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
        mapView.animate(with: update)
        mapView.setMinZoom(1, maxZoom: 18)
       
        
        let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
        infoWindow.lblCycleCount.isHidden = true
        infoWindow.ingTopConstraint.constant = 15
     //   infoWindow.lblCycleCount.text = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
        marker.iconView = infoWindow
        marker.map = mapView
        
        reverseGeocoding(marker: marker)*/
        
    }
    
}

// MARK:- Location Manager Delegate Methods
extension RequestHUBPinVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        self.locationManager.stopUpdatingLocation()
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        print("Locationnnnnnnnnnnnnnnnnnnnn")
        
       
        
        
//        if strCheckForCurrentLocation == "Menu"
//        {
//
//        }
//
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //marker.title = dicHub["stationName"]! as? String
        //marker.snippet = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
        
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18.0)
        mapView.animate(to: camera)
       // let marker = GMSMarker()
        
        
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(marker.position)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
        mapView.animate(with: update)
        mapView.setMinZoom(1, maxZoom: 18)
        marker.map = mapView
        
        let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
        infoWindow.lblCycleCount.isHidden = true
        infoWindow.ingTopConstraint.constant = 15
     //   infoWindow.lblCycleCount.text = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
        marker.iconView = infoWindow
        
        
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(location) { placemarks, error in
            
            if (error != nil) {
                
                print("reverse geocode fail: \(error?.localizedDescription ?? "")")
            }
            else {
                
                if placemarks != nil {
                    
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        
                        let pm = placemarks![0]
                        
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + " "
                        }
                        
                        print(addressString)
                        
                        self.lblCurrentAddress.text = addressString
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
//        // Check accuracy authorization
//        let accuracy = manager.accuracyAuthorization
//        switch accuracy {
//        case .fullAccuracy:
//            print("Location accuracy is precise.")
//        case .reducedAccuracy:
//            print("Location accuracy is not precise")
//        default:
//            fatalError()
//        }
//
//        // Handle authorization status
//        switch manager.authorizationStatus {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways:
//            fallthrough
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//        default:
//            fatalError()
//        }
        
    }
    
    func locationManager( _ manager: CLLocationManager, didFailWithError error: Error) {
        
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
}






