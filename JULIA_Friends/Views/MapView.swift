//
//  MapView.swift
//  JULIA_Friends
//
//  Created by Julia Rawlinson on 2021-11-25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject private var locationHelper : LocationHelper
    let friend : Friend
    
    var body: some View {
        VStack{
            if (self.locationHelper.currentLocation != nil){
                MyMap(location: self.locationHelper.currentLocation!)
            }else{
                Text("Obtaining user location...")
            }
        }
        .onAppear(){
            self.locationHelper.checkPermission()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(friend: Friend())
    }
}

struct MyMap: UIViewRepresentable{
    typealias UIViewType = MKMapView
    
    @EnvironmentObject var locationHelper : LocationHelper
    private var location: CLLocation
    let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    
    init(location: CLLocation){
        self.location = location
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if (self.locationHelper.currentLocation != nil){
            sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054)
        }
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let map = MKMapView(frame: .infinite)
        
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isUserInteractionEnabled = true
        map.setRegion(region, animated: true)
        //self.locationHelper.addPinToMapView(mapView: map, coordinates: sourceCoordinates, title: "You're Here")
        
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if (self.locationHelper.currentLocation != nil){
            sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054)
        }
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        uiView.setRegion(region, animated: true)
        //self.locationHelper.addPinToMapView(mapView: uiView, coordinates: sourceCoordinates, title: "You're Here")
    }
}
