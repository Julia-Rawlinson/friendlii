//
//  LocationHelper.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-24.
//

import Foundation
import CoreLocation
import SwiftUI

public class LocationHelper : NSObject, ObservableObject {
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation? = nil
    private var lastLocation : CLLocation? = nil
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        
        //Obtain location permissions and start updating
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.checkPermission()
        } else {
            print(#function, "Location services are not enabled")
        }
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    //Obtains appropriate location services permission
    public func checkPermission(){
        print(#function, "Checking for permission")
        switch self.locationManager.authorizationStatus {
        case .denied:
            print(#function, "No access, requesting")
            self.requestLocationPermission()
        case .notDetermined:
            print(#function, "No access, requesting")
            self.requestLocationPermission()
        case .restricted:
            print(#function, "No access, requesting")
            self.requestLocationPermission()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            print(#function, "Authorized Always, starting location updates")
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            print(#function, "Authorized When in Use, starting location updates")
        default:
            break
        }
    }
    
    //Request when in use authorization from the user
    public func requestLocationPermission(){
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func doGeocoding(address: String, completionHandler: @escaping(CLLocation?, String?, NSError?) -> Void){
        self.geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil{
                completionHandler(nil, nil,error as NSError?)
            }else{
                if let placemark = placemarks?.first{
                    let location = placemark.location!
                    
                    if(placemark.isoCountryCode != nil){
                        print(#function, "location: ", location.coordinate)
                        print(#function, "code: ", placemark.isoCountryCode!)
                        completionHandler(location, placemark.isoCountryCode, nil)
                        return
                    }
                }
                completionHandler(nil, nil,error as NSError?)
            }
        })
    }
    
}

extension LocationHelper : CLLocationManagerDelegate {
    
    //Tells the delegate that new location data is available
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        self.lastLocation = locations.first
        self.currentLocation = locations.last != nil ? locations.last! : locations.first
    }
    
    //Tells the delegate when the app creates the location manager and when the
    //authorization status changes
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
        if(self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse){
            locationManager.startUpdatingLocation()
            print(#function, "Inside callback, starting updates")
        }
    }
     
    //Tells the delegate that the location manager was unable to retrieve a location value
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Error: \(error.localizedDescription)")
    }
    
}
