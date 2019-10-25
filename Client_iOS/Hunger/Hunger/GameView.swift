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
    
    
    // Distance upon reaching (<=) which two users are thought to collide
    let collisionDistance: Double = 3
    
    var collisionHappened = false
    
    // MARK: Saving score
    
    
    // Every 30 minutes seconds of playing a human player receices a score.
    // This timer fires every 30 minutes (1800 seconds) calling addScore(Timer).
    let secondsToScore = 3 //1800
    let timer = GameViewTimer()
    let fsdb: FirestoreManager! = FirestoreManager()
    let scoreCollectionPath = "score"
//    var pathToUid: String {
//        get {
//            scoreCollectionPath + "/" + session.user!.uid
//        }
//    }
    
    
    // TODO abstract to a cloud function for better control
    
    
    
    // MARK: Init
    
    init(playsAs: PlayAs){
        self.playsAs = playsAs
        self.mapViewMK = MapViewMK(playAs: playsAs)
    }
    
    // MARK: Body
    
    @ViewBuilder
    var body: some View { 
        if( !(locationManager.zombieCollidedWithHuman && self.playsAs == .human) ){
            ZStack(alignment: Alignment.bottomTrailing){
                
                mapViewMK.onAppear{
                    self.session.user!.playsAs = self.playsAs
                    self.locationManager.goOnline()
                    
                    // Start a timer that updates score for a human player in dependency of time the user has spent online
                    // TODO maybe abstract saving to database to a cloud function for better control for additional costs of cloud function?
                    if self.session.user!.playsAs == .human {
                        self.timer.startTimer(timeInterval: TimeInterval(self.secondsToScore), withBlock: { timer in
                            // Make sure we have current score
                            if self.session.user!.score == nil {
                                
                                var snapshot: Dictionary<String, Any>?
                                if let result = self.fsdb.readDocument(withDocumentPath: self.session.user!.uid, atCollectionPath: self.scoreCollectionPath){
                                    snapshot = result
                                } else {
                                    snapshot = [:]
                                }
                                
                                let scoreEntry: (String, Any)? = snapshot?.first
                                if let score = scoreEntry?.1 as? Int{
                                    self.session.user!.score = score
                                } else {
                                    self.session.user!.score = 0
                                }
                            }
                            
                            self.session.user!.score! += 1
                            
                            self.fsdb.updateDocument(
                                ["value" : self.session.user!.score!], withDocumentPath: self.session.user!.uid, atCollectionPath: self.scoreCollectionPath)
                            print("Updated score for user \(self.session.user!.uid)")
                        })
                    }
                    
                    
                    print("Came online.")
                }.onDisappear{
                    self.locationManager.goOffline()
                    self.session.user!.playsAs = nil
                    print("Went offline.")
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
        GameView(
            playsAs: .zombie
        )
    }
}
