//
//  MainMenuView.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {
   @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        Group {
          if (session.user != nil) {
            Text("Hello user!")
          } else {
            LoginView()
          }
        }.onAppear(perform: getUser)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView().environmentObject(SessionStore())
    }
}
