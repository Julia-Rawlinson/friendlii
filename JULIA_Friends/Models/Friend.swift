//
//  Friend.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-22.
//

import Foundation
import CoreLocation

struct Friend : Identifiable, Hashable {
    
    var id : String = ""
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var city: String = ""
    var country: String = ""
    var lat : Double = 0.0
    var lon : Double = 0.0
    var isoCountryCode : String = ""
}
