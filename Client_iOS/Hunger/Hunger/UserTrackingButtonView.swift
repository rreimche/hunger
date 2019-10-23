//
//  UserTrackingButtonView.swift
//  Hunger
//
//  Created by Roman Reimche on 23.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct UserTrackingButtonView: UIViewRepresentable {
    
    let mapView: MKMapView
    
    func makeUIView(context: Context) -> MKUserTrackingButton {
        let button = MKUserTrackingButton(mapView: mapView)
        return button
    }
    
    func updateUIView(_ uiView: MKUserTrackingButton, context: Context) {
        
    }
}
