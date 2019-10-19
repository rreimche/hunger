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
    @State var locationManager: LocationManager
    // TODO should I call MapView.updateView from a Coordinator?
    
    
    var body: some View {
        //MapView(locationManager: $locationManager)
        MapView(locationManager: $locationManager).onAppear{
            
        }.onDisappear {
            // TODO Stop location service
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(locationManager: LocationManager(session: SessionStore()))
    }
}
