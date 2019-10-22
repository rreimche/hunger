//
//  MKAnnotationForPlayers.swift
//  Hunger
//
//  Created by Roman Reimche on 22.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import MapKit

class MKAnnotationForPlayers: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var playsAs: PlayAs
    
    init(playsAs: PlayAs, coordinate: CLLocationCoordinate2D){
        self.playsAs = playsAs
        self.coordinate = coordinate
    }
    
    func setPlayerType(to playerType: PlayAs){
        self.playsAs = playerType
    }
}
