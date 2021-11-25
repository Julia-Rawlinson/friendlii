//
//  MapView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let friend : Friend
    
    var body: some View {
        Text("I'm the map im the map")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(friend: Friend())
    }
}
