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
import Firebase
import GeoFire

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager: CLLocationManager
    private var dbRef: DatabaseReference!
    private var geoFire: GeoFire!
    private var session: SessionStore!
    var didChange = PassthroughSubject<LocationManager, Never>()

    // TODO CLLocation -> CLLocation?, no marker and appropriate message if nil
    var lastKnownLocation: CLLocation = CLLocation(latitude: 0, longitude: 0) {
        didSet {
            didChange.send(self)
        }
    }

    init(manager: CLLocationManager = CLLocationManager(), session: SessionStore) {
        self.manager = manager
        self.dbRef = Database.database().reference()
        self.geoFire = GeoFire(firebaseRef: dbRef)
        self.session = session
        
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
            
            // TODO Post location to firebase
            self.dbRef.child("players-online").child(session.user!.uid).setValue(true)
            geoFire.setLocation(lastKnownLocation, forKey: session.user!.uid){ (error) in
                if (error != nil) {
                    print("An error occured: \(String(describing: error))")
                } else {
                    print("Saved location successfully!")
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
