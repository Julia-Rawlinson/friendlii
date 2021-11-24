//
//  LocationHelper.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-24.
//

import Foundation
import CoreLocation
import SwiftUI

public class LocationHelper : ObservableObject {
    
    private let geocoder = CLGeocoder()
    private let baseUrl = "https://flagcdn.com/80x60/"
    @Published var image : UIImage? = nil
    
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
        let queryString = baseUrl + code.lowercased() + ".png"
        print(#function, "URL: \(queryString)")
        guard let url = URL(string: queryString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
}


