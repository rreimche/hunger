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
    @State var locationManager = LocationManager()
    
    var body: some View {
        MapView(locationManager: $locationManager).onAppear {
//            self.locationManager.startUpdating()
            
        }.onDisappear {
            // TODO Stop location service
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(locationManager: LocationManager())
    }
}
