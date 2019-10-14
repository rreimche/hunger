//
//  LocationManager.swift
//  Hunger
//
//  Adapted from https://stackoverflow.com/questions/56533059/how-to-get-current-location-with-swiftui by Roman Reimche on 13.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager: CLLocationManager
    var didChange = PassthroughSubject<LocationManager, Never>()

    // TODO CLLocation -> CLLocation?, no marker and appropriate message if nil
    var lastKnownLocation: CLLocation = CLLocation(latitude: 0, longitude: 0) {
        didSet {
            didChange.send(self)
        }
    }

    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        
        super.init()
        
        //self.lastKnownLocation = CLLocation(latitude: 0, longitude: 0)
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }

//    func startUpdating() {
//        self.manager.delegate = self
//        self.manager.requestWhenInUseAuthorization()
//        self.manager.startUpdatingLocation()
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        
        if let newLocation = locations.last {
            lastKnownLocation = newLocation
        }
        
        // TODO Post location to firebase
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
