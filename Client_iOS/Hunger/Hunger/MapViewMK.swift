//
//  MapView.swift
//  Hunger
//
//  Created by Roman Reimche on 09.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewMK: UIViewRepresentable {
    let playAs: PlayAs
    var otherPlayersMarkers: [MKAnnotation] = []
    let mapViewDelegate: MKMapViewDelegateForPlayerMarkers = MKMapViewDelegateForPlayerMarkers()
    @ObservedObject var locationManager: LocationManager
    @EnvironmentObject var session: SessionStore
    let defaultMapZoom : Float = 3.0
    
     
    
    // MARK: Marker placement methods
    
    
    func markerIconView(for playerType: PlayAs) -> UIView {
        let child = UIHostingController(rootView: MarkerIconView(iconFor: playerType))
        let parent = UIViewController()
        let size = CGSize(width: 10, height: 10)
        parent.preferredContentSize = size
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = parent.view.bounds
        // First, add the view of the child to the view of the parent
        parent.view.addSubview(child.view)
        // Then, add the child to the parent
        parent.addChild(child)
        parent.view.frame.size = size
        
        return parent.view
        
        /*// Then, remove the child from its parent
        child.removeFromParent()

        // Finally, remove the child’s view from the parent’s
        child.view.removeFromSuperview()*/
    }
    
    // MARK: UIViewRepresentable
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let startingRegion = MKCoordinateRegion(center: locationManager.lastKnownLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        
        /*let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)*/
        
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.setRegion(startingRegion, animated: true)
        //mapView.setUserTrackingMode(.follow, animated: true) //.followWithHeading
        self.mapViewDelegate.setPlayerType(playsAs: self.playAs)
        mapView.delegate = self.mapViewDelegate
        
        
        //mapView.center = view.center
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context){
        
        print("Updating MapViewMK")
        
        // TODO add smarter updating of the markers – change positions instead of replacing
        mapView.removeAnnotations(otherPlayersMarkers)
        for (user, _) in locationManager.nearbyPlayers {
           //TODO take playAs from user
            mapView.addAnnotation(MKAnnotationForPlayers(playsAs: .zombie, coordinate: user.location!.coordinate ))
        }
    }
     
}

struct MapViewMK_Previews: PreviewProvider {
    
    @ObservedObject static var locationManager = LocationManager(session: SessionStore())
    
//    init() {
//        MapView_Previews.self.locationManager.startUpdating()
//    }
    
    static var previews: some View {
        MapViewMK(playAs: .zombie, locationManager: locationManager)
    }
}
