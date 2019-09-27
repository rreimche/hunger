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
                Section(header: Text("Play as")) {
                    NavigationLink(destination: PlayAsHumanView()){ Text("👩🏻‍💼🙎🏻‍♂️").font(.largeTitle).multilineTextAlignment(.center) }
                    NavigationLink(destination: PlayAsZombieView()){ Text("🧟‍♀️🧟‍♂️").font(.largeTitle).multilineTextAlignment(.center) }
                }
                
                Section{
                    NavigationLink(destination: HallOfFameView()){ Text("Hall of the Toughest 👍") }
                }
                
                Section {
                    Button(action: logOut) { Text("Log out") }
                }
            }.navigationBarTitle("Main Menu")
        }
        
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView().environmentObject(SessionStore())
    }
}
