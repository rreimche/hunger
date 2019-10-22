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
    
    //@EnvironmentObject var session: SessionStore
    @ObservedObject var locationManager: LocationManager
    // TODO should I call MapView.updateView from a Coordinator?
    
    
    // Distance upon reaching (<=) which two users are thought to collide
    let collisionDistance: Double = 3
    
    var collisionHappened = false
    
    @ViewBuilder
    var body: some View { 
        if( !locationManager.collisionHappened ){
            
            MapViewMK(playAs: self.playAs, locationManager: locationManager)
                 .onAppear{
            
                }.onDisappear {
                // TODO Stop location service
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
