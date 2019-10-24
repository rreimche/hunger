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
    let playsAs: PlayAs
    let mapViewMK: MapViewMK
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var locationManager: LocationManager
    // TODO should I call MapView.updateView from a Coordinator?
    
    
    // Distance upon reaching (<=) which two users are thought to collide
    let collisionDistance: Double = 3
    
    var collisionHappened = false
    
    init(playAs: PlayAs){
        self.playsAs = playAs
        self.mapViewMK = MapViewMK(playAs: playAs)
    }
    
    @ViewBuilder
    var body: some View { 
        if( !(locationManager.zombieCollidedWithHuman && self.playsAs == .human) ){
            ZStack(alignment: Alignment.bottomTrailing){
                // TODO find a way for LocationManager to start providing locations only when .startUpdatingLocations() is called.
                mapViewMK.onAppear{
                    self.session.user!.playsAs = self.playsAs
                    self.locationManager.startUpdatingLocations()
                    print("Started updating locations.")
                    //self.mapViewMK.startTrackingUser()
                }.onDisappear {
                    self.locationManager.stopUpdatingLocations()
                    self.session.user!.playsAs = nil
                    print("Stopped updating locations.")
                }
                UserTrackingButtonView(mapView: mapViewMK.mapView)
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                    .offset(x: -20, y: -20)
            
            }
            
        } else {
            GameOverView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(playAs: .zombie)
    }
}
