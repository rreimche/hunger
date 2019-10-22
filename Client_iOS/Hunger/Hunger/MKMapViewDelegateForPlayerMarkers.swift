//
//  MKMapViewDelegateForPlayerMarkers.swift
//  Hunger
//
//  Created by Roman Reimche on 22.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import MapKit

class MKMapViewDelegateForPlayerMarkers: NSObject, MKMapViewDelegate {
    var playsAs : PlayAs?
    
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
            
            switch self.playsAs {
            case .human: markerView.glyphText = "👩🏻‍💼"
            case .zombie: markerView.glyphText = "🧟‍♀️"
            default: return nil
            }
            
            return markerView
        }
        
        return nil
        
    }
}
