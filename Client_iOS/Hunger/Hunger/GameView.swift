//
//  GameView.swift
//  Hunger
//
//  Created by Roman Reimche on 09.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMaps
import CoreLocation

struct GameView: View {
    
    // If the player would play as a Zombie or as a Human
    let playAs: PlayAs
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var locationManager: LocationManager
    // TODO should I call MapView.updateView from a Coordinator?
    
    
    // Distance upon reaching (<=) which two users are thought to collide
    let collisionDistance: Double = 3
    
    var collisionHappened = false
    
//    init(playAs: PlayAs){
//        self.playAs = playAs
//        self.locationManager = locationManager(session:session)
//    }
    
    @ViewBuilder
    var body: some View { 
        if( !locationManager.collisionHappened ){
            // TODO find a way for LocationManager to start providing locations only when .startUpdatingLocations() is called.
            MapViewMK(playAs: self.playAs, locationManager: locationManager)
                 .onAppear{
                    self.session.user!.playsAs = self.playAs
                    self.locationManager.startUpdatingLocations()
                    print("Started updating locations.")
                }.onDisappear {
                // TODO Stop location service
                    self.locationManager.stopUpdatingLocations()
                    self.session.user!.playsAs = nil
                    print("Stopped updating locations.")
                }
            
        } else {
            GameOverView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(playAs: .zombie, locationManager: LocationManager(session: SessionStore()))
    }
}
