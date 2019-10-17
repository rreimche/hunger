//
//  MapView.swift
//  Hunger
//
//  Created by Roman Reimche on 09.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    @Binding var locationManager: LocationManager
    
    //@State var selfMarker = GMSMarker()
    
    func placeNewSelfMarker(on mapView: GMSMapView, at position: CLLocationCoordinate2D){
        let selfMarker = GMSMarker()
    
        // Creates a marker in the center of the map.
        // TODO find a way to change marker position without instance variable to avoid Fatal Error: accessing State outside View.body
        selfMarker.position = position
        selfMarker.title = "Me"
        selfMarker.snippet = "Some Text"
        selfMarker.map = mapView
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        // TODO provide backup solution for the case lastKnownLocation = nil
//        if (locationManager.lastKnownLocation != nil){
//            let coordinate = locationManager.lastKnownLocation!.coordinate
//        } else {
//            let coordinate = CLLocationCoordinate2D(latitude: 0,longitude: 0)
//        }
        let coordinate = locationManager.lastKnownLocation.coordinate
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 3.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        placeNewSelfMarker(on: mapView, at: coordinate)
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context){
        // TODO provide backup solution for the case lastKnownLocation = nil
        mapView.clear()
        placeNewSelfMarker(on: mapView, at: self.locationManager.lastKnownLocation.coordinate)
    }
    
}

struct MapView_Previews: PreviewProvider {
    
    @State static var locationManager = LocationManager(session: SessionStore())
    
//    init() {
//        MapView_Previews.self.locationManager.startUpdating()
//    }
    
    static var previews: some View {
        MapView(locationManager: $locationManager)
    }
}
