//
//  LocationHelper.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-24.
//

import Foundation
import CoreLocation

public class LocationHelper {
    
    private let geocoder = CLGeocoder()
    private let baseUrl = "https://flagcdn.com/80x60/"
    
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
    
    func getFlag(code: String){
        let queryString = baseUrl + code + ".png"
        
    }
    
    
}


