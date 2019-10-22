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
    //@EnvironmentObject var session: SessionStore
    @ObservedObject var locationManager: LocationManager
    // TODO should I call MapView.updateView from a Coordinator?
    
    
    // Distance upon reaching (<=) which two users are thought to collide
    let collisionDistance: Double = 3
    
    var collisionHappened = false
    
    @ViewBuilder
    var body: some View {
        //MapView(locationManager: $locationManager)
        if( locationManager.collisionHappened == false ){
            
            MapView(locationManager: locationManager)
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
        GameView(locationManager: LocationManager(session: SessionStore()))
    }
}
