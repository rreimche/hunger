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
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var session: SessionStore
    let defaultMapZoom : Float = 300.0
    let mapView: MKMapView
    
    func startTrackingUser(){
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    init(playAs: PlayAs){
        self.playAs = playAs
        self.mapView = MKMapView()
    }
    
     
    
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
        
        //let startingLocation = locationManager.lastKnownLocation ?? locationManager.defaultStartingLocation
        //let startingRegion = MKCoordinateRegion(center: startingLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        
        /*let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)*/
        
        mapView.mapType = .mutedStandard
        //mapView.setRegion(startingRegion, animated: true)
        //mapView.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: CLLocationDistance(defaultMapZoom), maxCenterCoordinateDistance: CLLocationDistance(defaultMapZoom)), animated: true)
        mapView.delegate = self.mapViewDelegate
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        self.mapViewDelegate.setPlayerType(playsAs: self.playAs)
        
        
        
        //mapView.center = view.center
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context){
        
        print("Updating MapViewMK")
        
        // TODO add smarter updating of the markers – change positions instead of replacing
//        for annotation in mapView.annotations {
//            if !(annotation is MKUserLocation) {
//                mapView.removeAnnotation(annotation)
//            }
//        }
        
        // Remove annotations for players that are no more nearby.
        var toRemove: [MKAnnotationForPlayers] = []
        for a in mapView.annotations {
            if a is MKUserLocation { continue }
            
            let annotation = a as! MKAnnotationForPlayers
            if !self.locationManager.nearbyPlayers.contains(where: { (key, _) -> Bool in
                
                key == annotation.playerUid
                
            }) {
                toRemove.append(annotation)
            }
        }
        
        mapView.removeAnnotations(toRemove)
        
        // Add annotations for players that have entered the nearby region.
        for (_, (user, _)) in self.locationManager.nearbyPlayers {
            if !mapView.annotations.contains(where: { (a) -> Bool in
                if a is MKUserLocation {
                    return false
                }
                
                let annotation = a as! MKAnnotationForPlayers
                
                return user.uid == annotation.playerUid
                
            }) {
                let newMarker = MKAnnotationForPlayers(playerUid: user.uid, playsAs: user.playsAs!, coordinate: user.location!.coordinate )
                mapView.addAnnotation(newMarker)
            }
        }
        
        
        // Animate location changes for players who moved inside the nearby region.
        UIView.animate(withDuration: 0.50){
            
            for a  in mapView.annotations {
                if a is MKUserLocation { continue }
                
                let annotation = a as! MKAnnotationForPlayers
                let (user, _) = self.locationManager.nearbyPlayers[annotation.playerUid]!
                annotation.coordinate = user.location!.coordinate
            }
            
//            for (_, (user, _)) in self.locationManager.nearbyPlayers {
    //            let newMarker = MKAnnotationForPlayers(playsAs: user.playsAs!, coordinate: user.location!.coordinate )
    //            mapView.addAnnotation(newMarker)
//            }
        }
    }
     
}

struct MapViewMK_Previews: PreviewProvider {
    
    @ObservedObject static var locationManager = LocationManager(session: SessionStore())
    
//    init() {
//        MapView_Previews.self.locationManager.startUpdating()
//    }
    
    static var previews: some View {
        MapViewMK(playAs: .zombie)
    }
}
