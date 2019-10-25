//
//  MainMenuView.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI
import Firebase

struct MainMenuView: View {
   @EnvironmentObject var session: SessionStore
   @EnvironmentObject var locationManager: LocationManager
    
    func displayName() -> String {
        
        if let displayName = session.user!.displayName {
            return displayName
        } else if let email = session.user!.email {
            return email
        } else {
            return "User"
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    } 
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    NavigationLink(destination: GameView(playsAs: .human)){ Text("Play as 👩🏻‍💼").font(.title)
                    }
                    
                    NavigationLink(destination: GameView(playsAs: .zombie)){ Text("Play as 🧟‍♀️").font(.title)
                    }
                    
                    
                }
                
                Section{
                    NavigationLink(destination: HallOfFameView()){ Text("The fittest 🤩")
                        
                    }
                }
                
                Section {
                    Button(action: logOut) { Text("Log out") }
                }
            }.navigationBarTitle("Main Menu")
            
        }.onAppear{
            // Reset collision status
            self.locationManager.zombieCollidedWithHuman = false
        }
        
    }
}


struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView().environmentObject(SessionStore())
    }
}
