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
    // NOTE: To process any events triggered inside GMSMapView,
    //       we must have a Coordinator as it's delegate (most probably...)
    //       At least this is a case with represented UIViewControllers,
    //       But I don't know if it's also so with UIViews.
    
    @ObservedObject var locationManager: LocationManager
    @EnvironmentObject var session: SessionStore
    let defaultMapZoom : Float = 3.0
    
    
//    init(){
//        defaultMapZoom = 3.0
//        locationManager = LocationManager(session: session)
//    }
    
    //@State var selfMarker = GMSMarker()
    
    // MARK: Marker placement methods
    
    func placeNewSelfMarker(on mapView: GMSMapView, at position: CLLocationCoordinate2D){
        let selfMarker = GMSMarker()
    
        // Creates a marker in the center of the map.
        // TODO find a way to change marker position without instance variable to avoid Fatal Error: accessing State outside View.body
        selfMarker.position = position
        selfMarker.title = "Me"
        selfMarker.snippet = "Some Text"
        selfMarker.map = mapView
    }
    
    func placeNearbyPlayersMarkers(on mapView: GMSMapView){
        for (user, _) in locationManager.nearbyPlayers {
            guard user.location != nil else {
                print("Warning: the user \(user.uid) has either no location for marker placement, therefore no marker is placed for him.")
                continue
            }
            
            // Place marker
            let marker = GMSMarker()
            marker.position = user.location!.coordinate
            marker.title = "A player"
            marker.snippet = "Some Text"
            marker.map = mapView
        }
    }
    
    func updateCameraPosition(for mapView: GMSMapView){
        mapView.animate(to: GMSCameraPosition.init(
            target: locationManager.lastKnownLocation.coordinate,
            zoom: defaultMapZoom
        ))
    }
    
    // MARK: UIViewRepresentable
    
    func makeUIView(context: Context) -> GMSMapView {
        // TODO provide backup solution for the case lastKnownLocation = nil
//        if (locationManager.lastKnownLocation != nil){
//            let coordinate = locationManager.lastKnownLocation!.coordinate
//        } else {
//            let coordinate = CLLocationCoordinate2D(latitude: 0,longitude: 0)
//        }
        let coordinate = locationManager.lastKnownLocation.coordinate
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: defaultMapZoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        placeNewSelfMarker(on: mapView, at: coordinate)
        
        // TODO Hide Map and show placeholder
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context){
        // TODO provide backup solution for the case lastKnownLocation = nil
        print("Updating MapView")
        
        // TODO remove the placeholder if present
        
        mapView.clear()
        placeNewSelfMarker(on: mapView, at: self.locationManager.lastKnownLocation.coordinate)
        updateCameraPosition(for: mapView)
        placeNearbyPlayersMarkers(on: mapView)
    }
    
}

struct MapView_Previews: PreviewProvider {
    
    @ObservedObject static var locationManager = LocationManager(session: SessionStore())
    
//    init() {
//        MapView_Previews.self.locationManager.startUpdating()
//    }
    
    static var previews: some View {
        MapView(locationManager: locationManager)
    }
}
