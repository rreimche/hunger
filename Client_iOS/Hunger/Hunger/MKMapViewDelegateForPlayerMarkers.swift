//
//  MKMapViewDelegateForPlayerMarkers.swift
//  Hunger
//
//  Created by Roman Reimche on 22.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import MapKit

// TODO make marker backgrounds transparent
class MKMapViewDelegateForPlayerMarkers: NSObject, MKMapViewDelegate {
    var playsAs : PlayAs?
    
    // TODO find a way for playsAs to be constantly set at init
    func setPlayerType(playsAs: PlayAs){
        self.playsAs = playsAs
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKAnnotationForPlayers {
        
            let theAnnotation = annotation as! MKAnnotationForPlayers
        
            let markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "playerAnnotation")
            
            markerView.canShowCallout = true
            
            switch theAnnotation.playsAs {
            case .human: markerView.glyphText = "👩🏻‍💼"
            case .zombie: markerView.glyphText = "🧟‍♀️"
            }
            
            //TODO? transparent ballon?
            
            return markerView
        } else if annotation is MKUserLocation {
            let markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "userLocationAnnotation")
            markerView.canShowCallout = true
            
            switch self.playsAs! {
            case .human: markerView.glyphText = "👩🏻‍💼"
            case .zombie: markerView.glyphText = "🧟‍♀️" 
            }
            
            return markerView
        }
        
        return nil
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.setUserTrackingMode(.follow, animated: true) //.followWithHeading
    }
    
//    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, _: Bool) {
//        mapView.setUserTrackingMode(.follow, animated: true) //.followWithHeading
//    }
    
}
